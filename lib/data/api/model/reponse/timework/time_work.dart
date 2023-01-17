import 'package:choco_store_staff/data/api/model/reponse/timework/time_shift.dart';

import '../../base_model.dart';

class TimeWork extends BaseModel {
  String? id;
  String? idStore;
  List<TimeShift>? timeShift;
  TimeWork({this.id, this.idStore, this.timeShift});
  TimeWork.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idStore = json['idStore'];
    var list = json['timeshift'] as List;
    List<TimeShift> itemsList = list.map((i) => TimeShift.fromJson(i)).toList();
    timeShift = itemsList;
  }
}
