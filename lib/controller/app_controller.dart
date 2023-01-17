import 'dart:async';
import 'dart:io';
import 'package:choco_store_staff/data/api/constant_api.dart';
import 'package:choco_store_staff/data/storage/app_storage.dart';

import 'package:get/get.dart';
import 'package:event_bus/event_bus.dart';

import '../app/base_app_config.dart';
import '../data/api/rest_client.dart';
import '../utils/http_override.dart';
import '../utils/logger_debug/flutter_logger.dart';

class AppController extends GetxController {
  Rx<AuthState> authState = AuthState.unauthorized.obs;
  init(Environment environment) async {
    initLogger(environment);
    await initStorage();
    HttpOverrides.global = MyHttpOverrides();
    await setupLocator();
    final storage = Get.find<AppStore>();
    await initAuth(storage);
  }

  void initLogger(Environment environment) {
    Logger.init(
      environment == Environment.dev,
      isShowFile: true,
      isShowTime: false,
      isShowNavigation: true,
    );
  }

  Future<void> initAuth(AppStore storage) async {
    var user = await storage.getUserToken();
    Logger.d("User login reponse:${user?.account!.id}");
    // ignore: unnecessary_null_comparison
    if (user != null) {
      authState.value =
          user.token!.isEmpty ? AuthState.uncompleted : AuthState.authorized;
      await initApi(user.token!);
    } else {
      authState.value = AuthState.unauthorized;
      await initApi(null);
    }
  }

  Future<void> initStorage() async {
    await Get.put(AppStore()).init();
  }

  Future<void> initApi(String? accessToken) async {
    RestClient.instance.init(BASE_URL, accessToken: accessToken ?? "");
  }

  @override
  void onClose() {
    // Close all service
    Get.reset();
    super.onClose();
  }
}

// getLocation() async {
//   bool serviceEnabled;

//   LocationPermission permission;
//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled don't continue
//     // accessing the position and request users of the
//     // App to enable the location services.
//     await Geolocator.openLocationSettings();
//     return Future.error('Location services are disabled.');
//   }
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       // Permissions are denied, next time you could try
//       // requesting permissions again (this is also where
//       // Android's shouldShowRequestPermissionRationale
//       // returned true. According to Android guidelines
//       // your App should show an explanatory UI now.
//       return Future.error('Location permissions are denied');
//     }
//   }
//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately.
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }

//   // When we reach here, permissions are granted and we can
//   // continue accessing the position of the device.
//   final LocationSettings locationSettings = LocationSettings(
//     accuracy: LocationAccuracy.high,
//     distanceFilter: 100,
//   );

//   Geolocator.getPositionStream(locationSettings: locationSettings)
//       .listen((Position position) {
//     double distanceInMeters = Geolocator.distanceBetween(
//         10.98928, 106.69826, position.latitude, position.longitude);
//     Logger.d(" Meter: " + distanceInMeters.toString());
//     Logger.d("latitude: " + position.latitude.toString());
//     Logger.d("longititude: " + position.longitude.toString());
//   });
// }

EventBus eventBus = EventBus();

// ignore: constant_identifier_names
enum AuthState { unauthorized, authorized, uncompleted, new_install }
