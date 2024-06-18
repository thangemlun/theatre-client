import 'dart:convert';

import '../core/utils/typedef.dart';

class Schedule {
  late String title;
  late DateTime start_time;
  late String channel_id;
  late String full_title;
  late DateTime end_time;
  late String id;

  Schedule(this.id, this.title, this.channel_id, this.start_time, this.end_time, this.full_title);

  factory Schedule.fromJson(String src) => Schedule.fromMap(jsonDecode(src));

  Schedule.fromMap(DataMap dataMap) : this(
    dataMap["_id"] ?? "",
    dataMap["title"] ?? "",
    dataMap["channel_id"] ?? "",
    dataMap["start_time"] != null ?
    DateTime.fromMillisecondsSinceEpoch(dataMap["start_time"] * 1000,isUtc: false) :
    DateTime.now(),
    dataMap["end_time"] != null ?
    DateTime.fromMillisecondsSinceEpoch(dataMap["end_time"] * 1000,isUtc: false) :
    DateTime.now(),
    dataMap["full_title"] ?? "",
  );

}