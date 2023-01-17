import 'package:json_annotation/json_annotation.dart';

import 'date_time_utils.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String? strDate) {
    if (strDate == null) return null as DateTime;

    final strDateTime =
        strDate.contains("Z") ? strDate.split("Z").first : strDate;
    final substring = strDateTime.substring(strDate.length - 4);
    final format = strDate.contains("T")
        ? (substring.contains(".") ? DATE_TIME_FORMAT : DATE_FORMAT_FROM_API)
        : DATE_TIME_FORMAT3;

    final dateNew = parseDate(strDateTime, format, utc: false)!;
    return dateNew;
  }

  @override
  String toJson(DateTime date) => formatDate(date, DATE_TIME_FORMAT)!;
}

class DateConverter implements JsonConverter<DateTime, String> {
  const DateConverter();

  @override
  DateTime fromJson(String strDate) {
    return parseDate(strDate, DATE_FORMAT, utc: false)!;
  }

  @override
  String toJson(DateTime date) => formatDate(date, DATE_FORMAT)!;
}
