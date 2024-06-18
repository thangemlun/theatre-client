import 'dart:convert';

import 'package:learning_flutter/core/utils/typedef.dart';

class Channel {
  late String id;
  late String original_logo;
  late String alias_name;
  late String name;
  late String thumb;
  late String website_url;

  Channel(this.id, this.name, this.alias_name, this.original_logo, this.thumb, this.website_url);

  factory Channel.fromJson(String src) => Channel.fromMap(jsonDecode(src));

  Channel.fromMap(DataMap dataMap) : this(
    dataMap["_id"] ?? "",
    dataMap["name"] ?? "",
    dataMap["alias_name"] ?? "",
    dataMap["original_logo"] ?? "",
    dataMap["thumb"] ?? "",
    dataMap["website_url"] ?? ""
  );
}