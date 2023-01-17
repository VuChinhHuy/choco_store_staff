//  "id": "string",
//   "name": "string",
//   "price": 0,
//   "note": "string",
//   "detail": [
//     "string"
//   ],
//   "image": [
//     {
//       "number": 0,
//       "src": "string",
//       "alt": "string"
//     }
//   ],

import 'package:choco_store_staff/data/api/model/reponse/sales/category_reponse.dart';
import 'package:choco_store_staff/data/api/model/reponse/sales/partner_reponse.dart';

import '../../base_model.dart';
import '../../image_model.dart';

class ProductReponse extends BaseModel {
  String? _id;
  String? _name;
  int? _price;
  String? _note;
  List<String>? _detail;
  List<ImageModel>? _image;
  CategoryReponse? _category;
  PartnerReponse? _partner;

  String? get id => _id;
  String? get name => _name;
  int? get price => _price;
  String? get note => _note;
  List<String>? get detail => _detail;
  List<ImageModel>? get image => _image;
  CategoryReponse? get category => _category;
  PartnerReponse? get partner => _partner;
  ProductReponse({
    String? id,
    String? name,
    int? price,
    String? note,
    List<String>? detail,
    List<ImageModel>? image,
    CategoryReponse? category,
    PartnerReponse? partner,
  }) {
    _id = id;
    _name = name;
    _price = price;
    _note = note;
    _detail = detail;
    _image = image;
    _category = category;
    _partner = partner;
  }

  ProductReponse.fromJson(dynamic json) : super.fromJson(json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'];
    _note = json['note'];
    var detail = json['detail'] as List;
    _detail = detail.map((e) => e.toString()).toList();
    var image = json['image'] as List;
    _image = image.map((e) => ImageModel.fromJson(e)).toList();
    _category = CategoryReponse.fromJson(json['category']);
    _partner = PartnerReponse.fromJson(json['partner']);
  }
  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['price'] = _price;
    map['note'] = _note;
    map['detail'] = _detail;
    map['image'] = _image?.map((e) => e.toJson()).toList();
    map['category'] = _category?.toJson();
    map['partner'] = _partner?.toJson();
    map.removeWhere((dynamic key, dynamic value) =>
        key == null || value == null || value == '');
    return map;
  }
}
