import 'dart:convert';
import 'dart:ffi';

import 'package:learning_flutter/core/utils/constant.dart';

import '../core/utils/typedef.dart';

class Movie {
  late int id;
  late String name;
  late String slug;
  late String en_name;
  late String poster;
  late String seo_description;
  late int star_rating_value;
  late int star_rating_count;
  late String duration;
  late String imdb;
  late String release;
  late DateTime releaseDate;

  Movie(
      this.id,
      this.name,
      this.slug,
      this.en_name,
      this.poster,
      this.star_rating_value,
      this.star_rating_count,
      this.duration,
      this.imdb,
      this.release,
      this.releaseDate,
      this.seo_description);

  factory Movie.fromJson(String source) =>
      Movie.fromMap(jsonDecode(source) as DataMap);

  Movie.fromMap(DataMap dataMap)
      : this(
            dataMap["id"],
            dataMap["name"],
            dataMap["slug"] ?? "",
            dataMap["en_name"] ?? "",
            dataMap["poster"] ?? "",
            dataMap["star_rating_value"] ?? "",
            dataMap["star_rating_count"] ?? "",
            dataMap["duration"] ?? "",
            dataMap["imdb"] ?? "",
            dataMap["release"] ?? "",
            dataMap["releaseDate"] != null ?
            DateTime.fromMillisecondsSinceEpoch(dataMap["releaseDate"], isUtc: true) :
            DateTime.now(),
            dataMap["seo_description"] ?? "");
}
