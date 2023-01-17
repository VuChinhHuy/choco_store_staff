import 'dart:async';

import 'package:choco_store_staff/app/app_pages.dart';
import 'package:choco_store_staff/controller/base_controller.dart';
import 'package:choco_store_staff/data/api/model/reponse/profile/profile_store.dart';
import 'package:choco_store_staff/data/api/model/reponse/profile/profile_user.dart';
import 'package:choco_store_staff/data/api/model/reponse/timework/calendar_work.dart';
import 'package:choco_store_staff/data/api/model/reponse/timework/time_shift.dart';
import 'package:choco_store_staff/data/api/model/request/register_calendar_work/check_in_out.dart';
import 'package:choco_store_staff/data/api/service/register_calendar_service.dart';
import 'package:choco_store_staff/data/repositories/store_repository.dart';
import 'package:choco_store_staff/data/storage/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../data/api/model/reponse/timework/calendar_work.dart';
import '../../data/api/model/reponse/timework/time_work.dart';
import '../../data/repositories/profile_user_repository.dart';
import '../../data/repositories/register_work_repository.dart';
import '../../utils/date_time_utils.dart';
import '../../utils/logger_debug/flutter_logger.dart';

class HomeController extends BaseController {
  final storage = Get.find<AppStore>();
  final repostory = Get.find<ProfileUserRepository>();
  final registerSerivce = Get.find<RegisterWork>();
  final checkinoutSer = Get.find<RegisterCalendarWorkService>();

  final storeRe = Get.find<StoreRepository>();
  late Rx<ProfileUser> user = ProfileUser().obs;
  late Rx<ProfileStore> store = ProfileStore().obs;
  final List<DateTime> dayOfNextWeek = getWeek().obs;
  late Rx<TimeWork> timework = TimeWork().obs;
  final RxList<CalendarWorkFromApi> calendarTimeShift1 =
      RxList<CalendarWorkFromApi>();
  final RxList<CalendarWorkFromApi> calendarTimeShift2 =
      RxList<CalendarWorkFromApi>();
  final RxList<CalendarWorkFromApi> calendarTimeShift3 =
      RxList<CalendarWorkFromApi>();
  late StreamSubscription<Position> streamSubscription;
  late Rx<Position> position;
  late RxBool isCheckin = false.obs;
  late TimeShift timeShiftCheck;
  @override
  void onInit() async {
    super.onInit();
    await loadData();
  }

  loadData() async {
    await getLocation();
    try {
      await repostory.getUser().then((value) async {
        Logger.d(value);
        await storage.saveUserInfo(value);
        user.value = value;
      });
      final storeGet = await storeRe.getStore();
      store.value = storeGet;
      final timeWork = await registerSerivce.getTimeWork();
      timework.value = timeWork;
      await setTimeShift();
    } catch (e) {
      logout();
    }
  }

  setTimeShift() async {
    for (int i = 0; i < timework.value.timeShift!.length; i++) {
      if (i == 0) calendarTimeShift1.value = await getTimeShift(i);
      if (i == 1) calendarTimeShift2.value = await getTimeShift(i);
      if (i == 2) calendarTimeShift3.value = await getTimeShift(i);
    }
  }

  getTimeShift(int timshift) async {
    List<CalendarWorkFromApi> timeShift1 = [];
    final listTimeShift = await registerSerivce.getCalendarWorkInWeek();

    listTimeShift.toList().forEach((element) {
      if (element.timeShift!.isNotEmpty) {
        if (element.timeShift?[0].timeShift?.name ==
            timework.value.timeShift?[timshift].name) {
          CalendarWorkFromApi calendar = CalendarWorkFromApi();
          calendar.time = element.time;
          calendar.timeShift = element.timeShift;
          timeShift1.add(calendar);
        }
      }
    });
    List<CalendarWorkFromApi> timeShift2 = [];

    for (int i = 0; i < dayOfNextWeek.length; i++) {
      CalendarWorkFromApi calendar = CalendarWorkFromApi();
      calendar.time = dayOfNextWeek[i];
      calendar.timeShift = [];
      timeShift2.add(calendar);

      timeShift1.toList().forEach((element) {
        if (dayOfNextWeek[i].day == element.time!.day) {
          timeShift2[i].timeShift = element.timeShift;
          if (isToday(dayOfNextWeek[i])) {
            TimeOfDay timeStart = TimeOfDay(
                hour: element.timeShift![0].timeShift!.timeStart!.hour!,
                minute: element.timeShift![0].timeShift!.timeStart!.minute!);
            TimeOfDay timeEnd = TimeOfDay(
                hour: element.timeShift![0].timeShift!.timeEnd!.hour!,
                minute: element.timeShift![0].timeShift!.timeEnd!.minute!);
            if (isValidTimeRange(timeStart, timeEnd)) {
              timeShiftCheck = element.timeShift![0].timeShift!;
              element.timeShift![0].checkStart != null
                  ? isCheckin.value = true
                  : isCheckin.value = false;
            }
          }
        }
      });
    }

    return timeShift2;
  }

  getLocation() async {
    bool serviceEnabled;

    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    // ignore: prefer_const_declarations
    final LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    streamSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      this.position = position.obs;
    });
  }

  bool isValidTimeRange(TimeOfDay startTime, TimeOfDay endTime) {
    TimeOfDay now = TimeOfDay.now();
    return ((now.hour > startTime.hour) ||
            (now.hour == startTime.hour && now.minute >= startTime.minute)) &&
        ((now.hour < endTime.hour) ||
            (now.hour == endTime.hour && now.minute <= endTime.minute));
  }

  checkin() async {
    showLoading();
    double latStore = store.value.coordinates![0]; //vĩ độ cửa hàng;
    double longStore = store.value.coordinates![1]; // kinh độ cửa hàng;
    // double latStore = 10.98928; //vĩ độ cửa hàng;
    // double longStore = 106.69826;
    double latUser = position.value.latitude;
    double longUser = position.value.longitude;
    double distanceInMeters =
        Geolocator.distanceBetween(latStore, longStore, latUser, longUser);

    if (distanceInMeters <= 50.0) {
      CheckInOutModel check = CheckInOutModel();
      check.staff = user.value;
      TimeOfDay now = TimeOfDay.now();
      check.timecheck = time(hour: now.hour, minute: now.minute);
      timework.value.timeShift!.toList().forEach((element) async {
        TimeOfDay timeStart = TimeOfDay(
            hour: element.timeStart!.hour!, minute: element.timeStart!.minute!);
        TimeOfDay timeEnd = TimeOfDay(
            hour: element.timeEnd!.hour!, minute: element.timeEnd!.minute!);
        //check time now in ca số mấy???
        if (isValidTimeRange(timeStart, timeEnd)) {
          timeShiftCheck = element;
          check.timeShift = element;
          await checkinoutSer.CheckIn(check.toJson()).then((value) async {
            if (value.toString().contains("OK")) {
              await setTimeShift();
              Get.snackbar("Check in", value);
              isCheckin.value = true;
            } else if (value.toString().contains("Không có ca") ||
                value.toString().contains("Không có lịch")) {
              Get.snackbar("Check in", value);
              isCheckin.value = false;
            } else {
              Get.snackbar("Check in", value);
              isCheckin.value = true;
            }
          });
        }
        // else {
        //   Get.snackbar("Cảnh báo!", "Chưa đến giờ làm!");
        // }
      });
    } else {
      // Get.dialog(widget)
      Get.snackbar("Cảnh báo!", "Bạn chưa đi làm! Hãy đi làm rồi check in!!");
    }
    showEmpty();
  }

  checkout() async {
    showLoading();
    double latStore = store.value.coordinates![0]; //vĩ độ cửa hàng;
    double longStore = store.value.coordinates![1]; // kinh độ cửa hàng;
    // double latStore = 10.98928; //vĩ độ cửa hàng;
    // double longStore = 106.69826;
    double latUser = position.value.latitude;
    double longUser = position.value.longitude;
    double distanceInMeters =
        Geolocator.distanceBetween(latStore, longStore, latUser, longUser);

    if (distanceInMeters <= 50.0) {
      CheckInOutModel check = CheckInOutModel();
      check.staff = user.value;
      TimeOfDay now = TimeOfDay.now();
      check.timecheck = time(hour: now.hour, minute: now.minute);
      check.timeShift = timeShiftCheck;
      await checkinoutSer.CheckOut(check.toJson()).then((value) async {
        if (value.toString().contains("OK")) {
          Get.snackbar("Check out", value);
          await setTimeShift();
          isCheckin.value = false;
        }
      });
    }
    showEmpty();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }

  logout() {
    Get.find<AppStore>().logout();
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  toCalendarPage() {
    Get.toNamed(AppRoutes.REGISTER_CALENDAR);
  }

  toSalesPage() {
    Get.toNamed(AppRoutes.SALES);
  }
}
