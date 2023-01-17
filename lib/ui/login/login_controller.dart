import 'package:choco_store_staff/app/app_pages.dart';
import 'package:choco_store_staff/controller/base_controller.dart';
import 'package:choco_store_staff/data/api/constant_api.dart';
import 'package:choco_store_staff/data/api/service/login_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/api/rest_client.dart';
import '../../data/api/service/login_service.dart';
import '../../data/storage/app_storage.dart';
import '../../utils/logger_debug/flutter_logger.dart';

class LoginController extends BaseController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final loginService = Get.find<LoginService>();
  final storage = Get.find<AppStore>();
  RxBool check = true.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }

  login() async {
    try {
      showLoading();
      final userLogin = await loginService.login(
          usernameController.text, passwordController.text);
      await storage.saveUserToken(userLogin);
      RestClient.instance.init(BASE_URL, accessToken: userLogin.token);
      showEmpty();
      Get.offAllNamed(AppRoutes.HOME);
    } catch (e) {
      Logger.e(e);
      Get.snackbar("Login", "Kiểm tra kết nối internet");
      showEmpty();
      showErrors(e);
    }
  }
}
