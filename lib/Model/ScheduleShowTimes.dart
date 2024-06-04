import 'dart:convert';

import 'package:learning_flutter/Model/ShowTime.dart';
import 'package:learning_flutter/core/utils/typedef.dart';

class ScheduleShowTimes {
  final String ?date;
  final List<ShowTime> ?showTimes;

  const ScheduleShowTimes({required this.date, required this.showTimes});

  factory ScheduleShowTimes.fromJson(String source) => ScheduleShowTimes.fromMap(jsonDecode(source) as DataMap);

  ScheduleShowTimes.fromMap(DataMap dataMap) : this (
    date: dataMap['date'] as String,
    showTimes: dataMap['showTimes'] as List<ShowTime>
  );
  
  DataMap toMap() => {
      'date' : date,
      'showTimes' : showTimes
  };

  String toJson() => jsonEncode(toMap());
}