import 'dart:convert';

import 'package:choco_store_staff/app/app_pages.dart';
import 'package:choco_store_staff/data/api/model/reponse/customer/customer.dart';
import 'package:choco_store_staff/data/api/model/reponse/sales/product_in_inventory.dart';
import 'package:choco_store_staff/data/api/model/request/order_request.dart';
import 'package:choco_store_staff/data/api/service/sales_service.dart';
import 'package:choco_store_staff/data/storage/app_storage.dart';
import 'package:choco_store_staff/ui/widget/order_succes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/base_controller.dart';
import '../../data/api/model/reponse/sales/product_reposne.dart';
import '../../utils/logger_debug/flutter_logger.dart';

class OrderSalesController extends BaseController {
  RxList<Map> listOrder = Get.arguments;

  RxDouble total = 0.0.obs;

  Rx<CustomerModel> customer = CustomerModel().obs;

  RxList<CustomerModel> listCustomer = [CustomerModel()].obs;

  TextEditingController textSearch = TextEditingController();

  final salesService = Get.find<SalesService>();

  final storage = Get.find<AppStore>();
  @override
  void onInit() async {
    super.onInit();
    calculatorTotal();
    await loadCustomer();
  }

  loadCustomer() async {
    final list = await salesService.getCustomer();
    listCustomer.value = [CustomerModel()];
    list.isEmpty
        ? listCustomer.value = [CustomerModel()]
        : listCustomer.value.addAll(list);
    listCustomer.refresh();
  }

  calculatorTotal() {
    double totalFrom = 0;
    listOrder.value.toList().forEach((element) {
      totalFrom +=
          (element['count'].toInt() * element['product']['price'].toDouble());
    });
    total.value = totalFrom;
  }

  removeProductItem(int index) {
    listOrder.removeAt(index);
    listOrder.refresh();
    calculatorTotal();
  }

  saveOrder() async {
    if (listOrder.isNotEmpty) {
      showLoading();
      var staff = await storage.getUserInfo();
      OrderRequest order = OrderRequest();
      order.OrderDate = DateTime.now();
      order.customer = customer.value;
      order.OrderStaff = staff;
      order.OrderDetails = listOrder
          .map((element) => ProductInInventory.fromJson(element))
          .toList();
      order.TotalRecord = total.value.toString();
      Logger.d(order.TotalRecord);
      final post = await salesService.PostOrder(order.toJson());
      if (post != null) {
        Get.dialog(
          OrderSuccess(buttonAction: (() {
            Get.back();
            Get.back(result: "Success");
            // Get.offNamed(AppRoutes.HOME);
            // Get.toNamed(AppRoutes.SALES);
          })),
          barrierDismissible: false,
        );
      }
      showEmpty();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
