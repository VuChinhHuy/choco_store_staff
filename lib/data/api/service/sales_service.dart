import 'package:choco_store_staff/data/api/constant_api.dart';
import 'package:choco_store_staff/data/api/model/reponse/customer/customer.dart';
import 'package:choco_store_staff/data/api/model/reponse/sales/product_reposne.dart';
import 'package:choco_store_staff/data/api/service/base_service.dart';
import 'package:sprintf/sprintf.dart';

import '../model/reponse/sales/inventory_manager.dart';

class SalesService extends BaseService {
  Future<List<ProductReponse>> getProduct() async {
    final result = await get(PRODUCT);
    return (result as List).map((e) => ProductReponse.fromJson(e)).toList();
  }

  Future<InventoryManagerModel> getProductInventory(String idStore) async {
    final result = await get(sprintf(PRODUCT_INVENTORY, [idStore]));
    return InventoryManagerModel.fromJson(result);
  }

  Future<dynamic> getProductInStoreDiff(String idProduct) async {
    return await get(sprintf(PRODUCT_IN_STORE_DIFF, [idProduct]));
  }

  Future<List<CustomerModel>> getCustomer() async {
    final result = await get(CUSTOMER);
    return result != null
        ? (result as List).map((e) => CustomerModel.fromJson(e)).toList()
        : [];
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> PostOrder(dynamic body) async {
    return await post(POST_ORDER, data: body);
  }
}
