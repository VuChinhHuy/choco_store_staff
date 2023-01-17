import 'package:choco_store_staff/ui/order_sales/order_sales_controller.dart';
import 'package:get/get.dart';

class OrderSalesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(OrderSalesController());
  }
}
