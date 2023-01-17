import 'package:choco_store_staff/data/api/model/reponse/sales/product_reposne.dart';

class ProductInInventory {
  int? count;
  ProductReponse? product;
  ProductInInventory({this.count, this.product});
  ProductInInventory.fromJson(Map<dynamic, dynamic> json) {
    count = json["count"];
    product = ProductReponse.fromJson(json["product"]);
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['product'] = product?.toJson();
    map.removeWhere((dynamic key, dynamic value) =>
        key == null || value == null || value == '');
    return map;
  }
}
