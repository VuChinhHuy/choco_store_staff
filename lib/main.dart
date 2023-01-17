import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/base_app_config.dart';
import 'app/main_app.dart';
import 'controller/app_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.put<AppController>(AppController()).init(Environment.dev);

  runApp(const ChocoStoreApp());
}
