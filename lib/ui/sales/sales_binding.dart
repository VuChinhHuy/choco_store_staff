import 'package:choco_store_staff/ui/sales/sales_controller.dart';
import 'package:get/instance_manager.dart';

class SalesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SalesController());
  }
}
