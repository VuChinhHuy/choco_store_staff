import 'package:choco_store_staff/data/api/model/base_model.dart';

class CustomerModel extends BaseModel {
  String? id;
  String? first_name;
  String? last_name;
  DateTime? birthday;
  String? phone;
  String? note;
  String? address;
  CustomerModel(
      {this.id,
      this.first_name,
      this.last_name,
      this.address,
      this.birthday,
      this.phone,
      this.note});
  CustomerModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    id = json["id"];
    first_name = json["first_name"];
    last_name = json["last_name"];
    birthday =
        json['birthday'] != null ? datetime.fromJson(json['birthday']) : null;
    phone = json['phone'];
    note = json['note'];
    address = json['address'];
  }
}
