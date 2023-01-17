import 'package:choco_store_staff/ui/home/home_page.dart';
import 'package:choco_store_staff/ui/login/login_page.dart';
import 'package:choco_store_staff/ui/register_calendar/register_calendar_binding.dart';
import 'package:choco_store_staff/ui/register_calendar/register_calendar_page.dart';
import 'package:choco_store_staff/ui/sales/sales_binding.dart';
import 'package:choco_store_staff/ui/sales/sales_page.dart';
import 'package:choco_store_staff/ui/splash/splash.dart';
import 'package:get/get.dart';

import '../ui/home/home_binding.dart';
import '../ui/login/login_binding.dart';

part 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.REGISTER_CALENDAR,
      page: () => RegisterCalendarPage(),
      binding: RegisterCalendarBinding(),
    ),
    GetPage(
      name: AppRoutes.SALES,
      page: () => SalesPage(),
      binding: SalesBinding(),
    ),
  ];
}
