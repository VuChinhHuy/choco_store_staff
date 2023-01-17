// ignore_for_file: non_constant_identifier_names

import 'package:choco_store_staff/data/api/model/reponse/profile/profile_user.dart';

import '../reponse/customer/customer.dart';
import '../reponse/sales/product_in_inventory.dart';

class OrderRequest {
  String? id;
  DateTime? OrderDate;
  DateTime? LastEditDate;

  ProfileUser? OrderStaff;

  CustomerModel? customer;
  int? BillStatus;
  int? PaymentMethos;
  List<ProductInInventory>? OrderDetails;

// Tổng tiền của bill
  String? TotalRecord;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrderDate'] = OrderDate?.toIso8601String();
    map['LastEditDate'] =
        // ignore: prefer_null_aware_operators
        LastEditDate != null ? LastEditDate?.toIso8601String() : null;
    map['OrderStaff'] = OrderStaff?.toJson();
    map['customer'] = customer?.toJson();
    map['BillStatus'] = 6;
    map['PaymentMethos'] = 0;
    map['OrderDetails'] = OrderDetails?.map((e) => e.toJson()).toList();
    map['TotalRecord'] = TotalRecord;
    // map.removeWhere((dynamic key, dynamic value) =>
    //     key == null || value == null || value == '');
    return map;
  }
}
