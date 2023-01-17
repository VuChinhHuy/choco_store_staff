import 'package:choco_store_staff/data/api/model/reponse/timework/time_shift.dart';

class ReigterWorkUI {
  int? day;
  List<TimeShiftChose>? timeShiftChose;
  ReigterWorkUI(this.day, this.timeShiftChose);
}

class TimeShiftChose {
  TimeShift? timeShift;
  bool chose = false;
  TimeShiftChose(this.timeShift, this.chose);
}
