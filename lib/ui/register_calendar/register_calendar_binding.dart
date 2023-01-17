import 'package:choco_store_staff/ui/register_calendar/register_calendar_controller.dart';
import 'package:get/instance_manager.dart';

class RegisterCalendarBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(RegisterCalendarController());
  }
}
