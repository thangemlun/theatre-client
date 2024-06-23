import 'dart:convert';

import '../core/utils/typedef.dart';

class City{
  late int apiId;
  late String name;
  late String code;

  City(this.apiId, this.name, this.code);

  factory City.fromJson(String source) =>
      City.fromMap(jsonDecode(source) as DataMap);

  City.fromMap(DataMap dataMap)
      : this(
      dataMap["apiId"] ?? 0,
      dataMap["name"] ?? "",
      dataMap["code"] ?? ""
  );

  DataMap toMap() => {
    'apiId' : apiId,
    'name' : name,
    'code' : code
  };

  String toJson() => jsonEncode(toMap());
}