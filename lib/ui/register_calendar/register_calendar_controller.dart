import 'package:choco_store_staff/controller/base_controller.dart';
import 'package:choco_store_staff/data/api/model/reponse/timework/time_shift.dart';
import 'package:choco_store_staff/data/api/service/register_calendar_service.dart';
import 'package:get/get.dart';

import '../../data/api/model/reponse/timework/register_work_ui.dart';
import '../../data/api/model/reponse/timework/time_work.dart';
import '../../data/api/model/request/register_calendar_work/calendar_work_request.dart';
import '../../data/repositories/profile_user_repository.dart';
import '../../data/repositories/register_work_repository.dart';

import '../../data/storage/app_storage.dart';
import '../../utils/date_time_utils.dart';
import '../../utils/logger_debug/flutter_logger.dart';

class RegisterCalendarController extends BaseController {
  RxList<DateTime> dayOfNextWeek = getNextWeek().obs;
  Rx<int> dateSelected = 0.obs;
  final storage = Get.find<AppStore>();
  final repostory = Get.find<ProfileUserRepository>();
  final registerSerivce = Get.find<RegisterWork>();
  late Rx<TimeWork> timework = TimeWork().obs;
  Rx<List<ReigterWorkUI>> registerworkUI = RxList<ReigterWorkUI>().obs;

  @override
  void onInit() async {
    super.onInit();
    await loadData();
  }

  loadData() async {
    final timeWork = await registerSerivce.getTimeWork();
    timework.value = timeWork;
    for (int i = 0; i < 7; i++) {
      List<TimeShiftChose> timeShiftChose = [];
      for (int j = 0; j < timeWork.timeShift!.length; j++) {
        var timeShift = TimeShiftChose(timeWork.timeShift![j], false);
        timeShiftChose.add(timeShift);
      }
      var work = ReigterWorkUI(i, timeShiftChose);
      registerworkUI.value.add(work);
    }
  }

  saveRegisterCalendar() async {
    List<CalendarRegisterFromUi> calendarRegisterFromUI = [];
    List<ReigterWorkUI> registerWorkUi = registerworkUI.value;
    for (int i = 0; i < registerWorkUi.length; i++) {
      DateTime time = dayOfNextWeek.value[i];
      List<TimeShift> timeShift = [];
      registerWorkUi[i].timeShiftChose!.toList().forEach((element) {
        if (element.chose == true) {
          timeShift.add(element.timeShift!);
        }
      });
      if (timeShift.isNotEmpty) {
        calendarRegisterFromUI.add(CalendarRegisterFromUi(time, timeShift));
      }
    }
    final staff = await storage.getUserInfo();
    CalendarWorkRequest calendarWorRequest =
        CalendarWorkRequest(staff, calendarRegisterFromUI);

    if (calendarWorRequest.calendarRegister!.isNotEmpty) {
      showLoading();
      final registerWorkService = Get.find<RegisterCalendarWorkService>();
      await registerWorkService
          .registerCalendar(calendarWorRequest.toJson())
          .then((value) => {Get.snackbar("Thông báo!", "Thêm lịch $value")});

      Get.back();
      showEmpty();
    } else {
      Get.snackbar("Cảnh báo!", "Hãy chọn lịch");
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
