import 'package:choco_store_staff/data/api/model/reponse/profile/profile_user.dart';
import '../../reponse/timework/time_shift.dart';

class CheckInOutModel {
  ProfileUser? staff;
  TimeShift? timeShift;
  time? timecheck;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['timecheck'] = timecheck!.toJson();
    map['timeShift'] = timeShift!.toJson();
    map['staff'] = staff!.toJson();
    map.removeWhere((dynamic key, dynamic value) =>
        key == null || value == null || value == '');
    return map;
  }
}
