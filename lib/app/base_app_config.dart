import 'package:choco_store_staff/data/api/service/login_service.dart';
import 'package:choco_store_staff/data/api/service/profile_user_service.dart';
import 'package:choco_store_staff/data/api/service/register_calendar_service.dart';
import 'package:choco_store_staff/data/api/service/sales_service.dart';
import 'package:choco_store_staff/data/api/service/store_service.dart';
import 'package:choco_store_staff/data/repositories/product_repository.dart';
import 'package:choco_store_staff/data/repositories/profile_user_repository.dart';
import 'package:choco_store_staff/data/repositories/register_work_repository.dart';
import 'package:choco_store_staff/data/repositories/store_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

enum Environment { dev, prod }

setupLocator() async {
  //Setup service
  Get.put(LoginService());
  Get.put(ProfileUserService());
  Get.put(RegisterCalendarWorkService());
  Get.put(StoreSerivce());
  Get.put(SalesService());

  // Setup reponsity
  Get.put(ProfileUserRepository());
  Get.put(RegisterWork());
  Get.put(StoreRepository());
  Get.put(ProductRepository());
}

setupStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}
