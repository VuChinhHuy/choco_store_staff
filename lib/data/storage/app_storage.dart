// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:choco_store_staff/data/api/rest_client.dart';
import 'package:choco_store_staff/utils/logger_debug/flutter_logger.dart';
import 'package:get_storage/get_storage.dart';

import '../api/constant_api.dart';
import '../api/model/reponse/login/login_reponse.dart';
import '../api/model/reponse/profile/profile_user.dart';

class AppStore {
  late GetStorage box;
  static const STORAGE_NAME = "chain_stores";
  static const USER_TOKEN = 'token_user';
  static const USER_INFO = 'user_info';
  static const LIST_ORDER = 'list_order';
  init() async {
    await GetStorage.init(STORAGE_NAME);
    box = GetStorage(STORAGE_NAME);
  }

  // Lưu token đăng nhập đã lấy về.
  Future<void> saveUserToken(LoginReponse userLogin) async {
    String json = jsonEncode(userLogin.toJson());
    await box.write(USER_TOKEN, json);
  }

  Future<LoginReponse?> getUserToken() async {
    final userToken = await box.read(USER_TOKEN);
    Logger.d(userToken);
    final u = userToken != null
        ? LoginReponse.fromJson(json.decode(userToken))
        : null;
    return u;
  }

  Future<void> saveUserInfo(ProfileUser infoUser) async {
    String json = jsonEncode(infoUser.toJson());
    await box.write(USER_INFO, json);
  }

  Future<ProfileUser?> getUserInfo() async {
    final infoUser = await box.read(USER_INFO);

    return infoUser != null
        ? ProfileUser.fromJson(json.decode(infoUser))
        : null;
  }

  Future<void> logout() async {
    if (box.hasData(USER_TOKEN)) await box.remove(USER_TOKEN);
    if (box.hasData(USER_INFO)) await box.remove(USER_INFO);
    if (box.hasData(LIST_ORDER)) await box.remove(LIST_ORDER);
    RestClient.instance.init(BASE_URL);
  }

  Future<void> saveListOrder(Map<String, dynamic> listNew) async {
    final list = await getListOrder();
    if (list.isNotEmpty) {
      list.add(listNew);
      if (box.hasData(LIST_ORDER)) await box.remove(LIST_ORDER);
      box.write(LIST_ORDER, jsonEncode(list));
    } else {
      List<Map<String, dynamic>> map = [];
      map.add(listNew);
      box.write(LIST_ORDER, jsonEncode(map));
    }
  }

  Future<void> removeListOrder(int index) async {
    final list = await getListOrder();
    list.removeAt(index);
    if (box.hasData(LIST_ORDER)) await box.remove(LIST_ORDER);
    box.write(LIST_ORDER, jsonEncode(list));
  }

  Future<List<Map<String, dynamic>>> getListOrder() async {
    final list = await box.read(LIST_ORDER);
    if (list != null) {
      return (json.decode(list) as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();
      // return json.decode(list);
    } else {
      return [];
    }
  }
}
