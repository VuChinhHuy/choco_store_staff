import 'package:choco_store_staff/data/api/model/reponse/profile/profile_user.dart';
import 'package:choco_store_staff/data/api/model/reponse/timework/time_shift.dart';

import '../../../../../utils/date_time_converter.dart';

class CalendarWork {
  String? id;
  String? idStore;
  List<YearWork>? year;
}

class YearWork {
  String? year;
  List<MonthWork>? month;
}

class MonthWork {
  String? month;
  List<DayWork>? day;
}

class DayWork {
  String? day;
  List<checkWork>? check;
}

// ignore: camel_case_types
class checkWork {
  TimeShift? timeShift;
  ProfileUser? staff;
  time? checkStart;
  time? checkEnd;
  checkWork.fromJson(Map<String, dynamic> json) {
    timeShift = TimeShift.fromJson(json['timeShift']);
    staff = ProfileUser.fromJson(json['staff']);
    checkStart =
        json['checkStart'] != null ? time.fromJson(json['checkStart']) : null;
    checkEnd =
        json['checkEnd'] != null ? time.fromJson(json['checkEnd']) : null;
  }
}

class CalendarWorkFromApi {
  DateTime? time;
  List<checkWork>? timeShift;
  CalendarWorkFromApi({this.time, this.timeShift});
  CalendarWorkFromApi.fromJson(Map<String, dynamic> json) {
    time = json['time'] != null
        ? const DateTimeConverter().fromJson(json['time'])
        : null;
    var list = json['timeshift'] != "" ? json['timeshift'] as List : [];
    List<checkWork> itemsList = list.map((i) => checkWork.fromJson(i)).toList();
    timeShift = itemsList;
    // timeShift =
    //     checkWork.fromJson(json['timeshift']['timeShift']) as List<checkWork>?;
  }
}
