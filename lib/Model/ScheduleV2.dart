
import 'dart:convert';

import '../core/utils/typedef.dart';

class ScheduleV2{
  late DateTime showDateTime;
  late String showTime;
  late String showTimeDuration;
  late String screenNumber;
  late String screenName;

  ScheduleV2(
      this.showDateTime,
      this.showTime,
      this.showTimeDuration,
      this.screenNumber,
      this.screenName);

  factory ScheduleV2.fromJson(String source) =>
      ScheduleV2.fromMap(jsonDecode(source) as DataMap);

  ScheduleV2.fromMap(DataMap dataMap)
      : this(
      dataMap["showDateTime"] != null ? DateTime.fromMillisecondsSinceEpoch(dataMap["showDateTime"]) :
      DateTime.now(),
      dataMap["showTime"] ?? "",
      dataMap["showTimeDuration"] ?? "",
      dataMap["screenNumber"] ?? "",
      dataMap["screenName"] ?? ""
  );

}