import 'dart:core';

import '../../../../../utils/date_time_converter.dart';
import '../../base_model.dart';

class ProfileUser extends BaseModel {
  // "id": "string",
  //   "fullname": "string",
  //   "birthday": "2022-11-29T21:58:48.588Z",
  //   "phone": "string",
  //   "address": "string",
  //   "avt": "string",
  //   "accountId": "string",
  //   "storeId": "string",
  String? id;
  String? fullname;
  DateTime? birthday;
  String? phone;
  String? address;
  String? avt;
  String? accountId;
  String? storeId;
  // constructor
  ProfileUser(
      {this.id,
      this.fullname,
      this.birthday,
      this.phone,
      this.address,
      this.avt,
      this.accountId,
      this.storeId});

  ProfileUser.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    {
      id = json['id'];
      fullname = json['fullname'] ?? 'null';
      birthday = json['birthday'] != null
          ? const DateTimeConverter().fromJson(json['birthday'])
          : null;
      phone = json['phone'] ?? 'null';
      address = json['address'] ?? 'null';
      avt = json['avt'] ?? 'null';
      accountId = json['accountId'] ?? 'null';
      storeId = json['storeId'] ?? 'null';
    }
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fullname": fullname,
      "birthday": birthday?.toIso8601String(),
      "phone": phone,
      "address": address,
      "avt": avt,
      "accountId": accountId,
      "storeId": storeId,
    };
  }
}
