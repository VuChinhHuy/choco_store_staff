import 'package:choco_store_staff/data/api/model/reponse/profile/profile_store.dart';
import 'package:get/get.dart';

import '../api/service/store_service.dart';
import '../storage/app_storage.dart';

class StoreRepository {
  final storeService = Get.find<StoreSerivce>();
  final storage = Get.find<AppStore>();

  Future<ProfileStore> getStore() async {
    final user = await storage.getUserInfo();
    final store = await storeService.getStore(user!.storeId!);
    return store;
  }
}
