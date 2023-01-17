class TimeShift {
  String? name;
  time? timeStart;
  time? timeEnd;
  TimeShift({this.name, this.timeStart, this.timeEnd});
  TimeShift.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    timeStart = time.fromJson(json["timeStart"]);
    timeEnd = time.fromJson(json["timeEnd"]);
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['timeStart'] = timeStart!.toJson();
    map['timeEnd'] = timeEnd!.toJson();
    map.removeWhere((dynamic key, dynamic value) =>
        key == null || value == null || value == '');
    return map;
  }
}

// ignore: camel_case_types
class time {
  int? hour;
  int? minute;
  time({this.hour, this.minute});
  time.fromJson(Map<String, dynamic> json) {
    hour = json["hour"];
    minute = json["minute"];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hour'] = hour;
    map['minute'] = minute;
    map.removeWhere((dynamic key, dynamic value) =>
        key == null || value == null || value == '');
    return map;
  }
}
