import 'package:choco_store_staff/data/api/model/reponse/timework/calendar_work.dart';
import 'package:get/get.dart';
import '../../utils/logger_debug/flutter_logger.dart';
import '../api/model/reponse/timework/time_work.dart';
import '../api/service/register_calendar_service.dart';
import '../storage/app_storage.dart';

class RegisterWork {
  final _registerWorkService = Get.find<RegisterCalendarWorkService>();
  final storage = Get.find<AppStore>();
  Future<TimeWork> getTimeWork() async {
    final user = await storage.getUserInfo();

    final timeWork =
        await _registerWorkService.getTimeWork(user!.storeId.toString());
    return timeWork;
  }

  Future<List<CalendarWorkFromApi>> getCalendarWorkInWeek() async {
    final user = await storage.getUserInfo();
    final result = await _registerWorkService.getCalendarWorkInWeek(user!);
    return result;
  }
}
