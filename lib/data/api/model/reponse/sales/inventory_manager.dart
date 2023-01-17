import 'package:choco_store_staff/data/api/model/reponse/sales/product_in_inventory.dart';

class InventoryManagerModel {
  String? id;
  String? idStore;
  List<ProductInInventory>? productInStore;
  InventoryManagerModel({this.id, this.idStore, this.productInStore});
  InventoryManagerModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    idStore = json["idStore"];
    var list = json["productInStore"] as List;
    productInStore = list.map((e) => ProductInInventory.fromJson(e)).toList();
  }
}
