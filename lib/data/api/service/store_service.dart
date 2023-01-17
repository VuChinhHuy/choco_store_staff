import 'package:choco_store_staff/data/api/constant_api.dart';
import 'package:choco_store_staff/data/api/model/reponse/profile/profile_store.dart';
import 'package:choco_store_staff/data/api/service/base_service.dart';
import 'package:sprintf/sprintf.dart';

class StoreSerivce extends BaseService {
  Future<ProfileStore> getStore(String idStore) async {
    final store = await get(sprintf(STORE_PRO, [idStore]));
    return ProfileStore.fromJson(store);
  }
}
