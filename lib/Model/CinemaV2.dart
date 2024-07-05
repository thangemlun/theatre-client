import 'dart:convert';

import 'package:learning_flutter/Model/ScheduleV2.dart';

import '../core/utils/typedef.dart';

class CinemaV2{
  late String cityName;
  late String name;
  late String address;
  late String avatar;
  late String logo;
  late int ratingCount;
  late double ratingValue;
  late List<ScheduleV2> schedules;
  late bool isExpanded;

  CinemaV2(
      this.cityName,
      this.name,
      this.address,
      this.avatar,
      this.logo,
      this.ratingCount,
      this.ratingValue,
      this.schedules,
      this.isExpanded);

  factory CinemaV2.fromJson(String source) =>
      CinemaV2.fromMap(jsonDecode(source) as DataMap);

  CinemaV2.fromMap(DataMap dataMap)
      : this(
      dataMap["cityName"] ?? "",
      dataMap["name"] ?? "",
      dataMap["address"] ?? "",
      dataMap["avatar"] ?? "",
      dataMap["logo"] ?? "",
      dataMap["ratingCount"] ?? 0,
      dataMap["ratingValue"] ?? 0.0,
      getMapSchedule(dataMap["schedules"]),
      false
  );

  static List<ScheduleV2> getMapSchedule(dataMap) {
    var rawSchedule = dataMap;
    List<ScheduleV2> resultList = [];

    for(var mapData in dataMap) {
      ScheduleV2 item = ScheduleV2.fromMap(mapData);
      resultList.add(item);
    }

    return resultList;
  }
}