import 'package:get/get.dart';

import '../api/model/reponse/profile/profile_user.dart';
import '../api/service/profile_user_service.dart';
import '../storage/app_storage.dart';

class ProfileUserRepository {
  final _proifleService = Get.find<ProfileUserService>();
  final storage = Get.find<AppStore>();

  Future<ProfileUser> getUser() async {
    final loginResponse = await storage.getUserToken();
    final response = await _proifleService.getUser(loginResponse!.account!.id!);
    return response;
  }
}
