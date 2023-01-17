import 'package:choco_store_staff/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/chain_store_theme.dart';
import 'app_pages.dart';

class ChocoStoreApp extends GetWidget<AppController> {
  const ChocoStoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          initialRoute: _getRoute(),
          getPages: AppPages.pages,
          theme: ChainStoreTheme.lightTheme,
          darkTheme: ChainStoreTheme.dartTheme,
          themeMode: ThemeMode.system,
          defaultTransition: Transition.fadeIn,
        ));
  }

  String _getRoute() {
    switch (controller.authState.value) {
      case AuthState.unauthorized:
        return AppRoutes.SPLASH;
      case AuthState.authorized:
        return AppRoutes.HOME;
      case AuthState.new_install:
        return AppRoutes.SPLASH;
      case AuthState.uncompleted:
        return AppRoutes.HOME;
      default:
        return AppRoutes.SPLASH;
    }
  }
}
