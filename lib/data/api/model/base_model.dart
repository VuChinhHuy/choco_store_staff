// ignore_for_file: non_constant_identifier_names

import 'dart:core';

import 'package:flutter/material.dart';

import '../../../utils/date_time_converter.dart';

class BaseModel {
  DateTime? create_at;
  DateTime? update_at;
  String? create_user;
  String? update_user;
  final DateTimeConverter datetime = const DateTimeConverter();

  BaseModel({
    @required this.create_at,
    @required this.update_at,
    @required this.create_user,
    @required this.update_user,
  });
  Map<String, dynamic> toJson() => <String, dynamic>{
        'create_at': create_at?.toIso8601String(),
        'update_at': update_at?.toIso8601String(),
        'create_user': create_user,
        'update_user': update_user
      };
  BaseModel.fromJson(Map<String, dynamic> json) {
    create_at =
        json['create_at'] != null ? datetime.fromJson(json['create_at']) : null;

    update_at =
        json['update_at'] != null ? datetime.fromJson(json['update_at']) : null;

    create_user = json['create_user'] ?? 'null';
    update_user = json['update_user'] ?? 'null';
  }
}
