import '../../base_model.dart';
import '../../reponse/profile/profile_user.dart';
import '../../reponse/timework/time_shift.dart';

class RegisterCalendarRequest extends BaseModel {
  ProfileUser? staff;
  List<TimeRegister>? timeRegister;

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['staff'] = staff;
    map['timeRegister'] = timeRegister;
    map.removeWhere((dynamic key, dynamic value) =>
        key == null || value == null || value == '');
    return map;
  }
}

class TimeRegister {
  DateTime? time;
  TimeShift? timeShift;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = time?.toIso8601String();
    map['timeShift'] = timeShift;
    map.removeWhere((dynamic key, dynamic value) =>
        key == null || value == null || value == '');
    return map;
  }
}
