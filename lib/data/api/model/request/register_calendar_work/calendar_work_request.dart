import 'package:choco_store_staff/data/api/model/reponse/profile/profile_user.dart';

import '../../reponse/timework/time_shift.dart';

class CalendarWorkRequest {
  ProfileUser? staff;
  List<CalendarRegisterFromUi>? calendarRegister;
  CalendarWorkRequest(this.staff, this.calendarRegister);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['staff'] = staff!.toJson();
    List<Map<String, dynamic>>? calendar = calendarRegister != null
        ? calendarRegister!.map((e) => e.toJson()).toList()
        : null;
    map['calendarRegister'] = calendar;
    map.removeWhere((dynamic key, dynamic value) =>
        key == null || value == null || value == '');
    return map;
  }
}

class CalendarRegisterFromUi {
  DateTime? datetime;
  List<TimeShift>? timeShift;
  CalendarRegisterFromUi(this.datetime, this.timeShift);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = datetime?.toIso8601String();
    List<Map<String, dynamic>>? shift =
        timeShift != null ? timeShift!.map((e) => e.toJson()).toList() : null;
    map['timeShift'] = shift;
    map.removeWhere((dynamic key, dynamic value) =>
        key == null || value == null || value == '');
    return map;
  }
}
