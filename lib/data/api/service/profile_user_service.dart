import 'package:sprintf/sprintf.dart';

import '../../../utils/logger_debug/flutter_logger.dart';
import '../constant_api.dart';
import 'base_service.dart';
import '../model/reponse/profile/profile_user.dart';

class ProfileUserService extends BaseService {
  Future<ProfileUser> getUser(String accountId) async {
    final response = await get(sprintf(PROFILE_USER, [accountId]));
    return ProfileUser.fromJson(response);
  }
}
