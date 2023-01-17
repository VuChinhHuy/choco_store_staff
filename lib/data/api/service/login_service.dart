import 'dart:convert';

import '../constant_api.dart';
import '../model/reponse/login/login_reponse.dart';
import 'base_service.dart';

class LoginService extends BaseService {
  Future<LoginReponse> login(String username, String password) async {
    final queryParam = {
      'username': username,
      "password": password,
      "create_at": "2022-11-29T15:10:56.164Z",
      "update_at": "2022-11-29T15:10:56.164Z",
      "create_user": "string",
      "update_user": "string",
      "role": "string"
    };
    final reponse = await post(LOGIN,
        data: queryParam, responseType: JsonType.FULL_RESPONSE);
    return LoginReponse.fromJson(jsonDecode(reponse));
  }
}
