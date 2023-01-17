import 'package:choco_store_staff/data/api/model/reponse/profile/profile_user.dart';
import 'package:choco_store_staff/data/api/model/reponse/timework/calendar_work.dart';
import 'package:sprintf/sprintf.dart';

import '../constant_api.dart';
import '../model/reponse/timework/time_work.dart';
import 'base_service.dart';

class RegisterCalendarWorkService extends BaseService {
  Future<TimeWork> getTimeWork(String idStore) async {
    final timeWork = await get(sprintf(TIMEWORK, [idStore]));
    return TimeWork.fromJson(timeWork);
  }

  Future<dynamic> registerCalendar(dynamic data) async {
    return await post(REGISTER_TIMEWORK, data: data);
  }

  Future<List<CalendarWorkFromApi>> getCalendarWorkInWeek(
      ProfileUser profileUser) async {
    final result = await get(CALENDARWORK_STAFF_INWEEK,
        params: {"storeId": profileUser.storeId, "idStaff": profileUser.id});
    return (result as List)
        .map((e) => CalendarWorkFromApi.fromJson(e))
        .toList();
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> CheckIn(dynamic check) async {
    return await post(CHECK_IN, data: check);
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> CheckOut(dynamic check) async {
    return await post(CHECK_OUT, data: check);
  }
}
