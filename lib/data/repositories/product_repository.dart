import 'package:choco_store_staff/data/api/model/reponse/sales/product_in_inventory.dart';
import 'package:choco_store_staff/data/api/service/sales_service.dart';
import 'package:get/get.dart';
import '../storage/app_storage.dart';

class ProductRepository {
  final _salesService = Get.find<SalesService>();
  final storage = Get.find<AppStore>();
  Future<List<ProductInInventory>> getProductInVentory() async {
    final allProduct = await _salesService.getProduct();
    final user = await storage.getUserInfo();
    final productInventory =
        await _salesService.getProductInventory(user!.storeId!);
    List<ProductInInventory> product = [];
    allProduct.toList().forEach((element) {
      ProductInInventory pro = ProductInInventory();
      pro.product = element;
      pro.count = 0;
      product.add(pro);
      for (var item in productInventory.productInStore!.toList()) {
        if (element.id == item.product?.id) {
          product[product.indexOf(pro)].count = item.count;
          break;
        }
      }
    });

    return product;
  }

  Future<dynamic> getProductInStoreDiff(String idProduct) async {
    return await _salesService.getProductInStoreDiff(idProduct);
  }
}
