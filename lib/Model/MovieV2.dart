import 'dart:convert';
import 'dart:ffi';

import '../core/utils/typedef.dart';

class MovieV2 {
  late int id;
  late String title;
  late String apiFilmId;
  late String bannerUrl;
  late int duration;
  late String graphicUrl;
  late String apiFilmType;
  late String apiRating;
  late String apiCaptionType;
  late String apiRatingFormat;
  late String apiGenreName;
  late String openingDate;
  late String synopsis;
  late String synopsisEn;
  late String titleEn;
  late String trailerUrl;

  MovieV2(
      this.id,
      this.title,
      this.apiFilmId,
      this.bannerUrl,
      this.duration,
      this.graphicUrl,
      this.apiFilmType,
      this.apiRating,
      this.apiCaptionType,
      this.apiRatingFormat,
      this.apiGenreName,
      this.openingDate,
      this.synopsis,
      this.synopsisEn,
      this.titleEn,
      this.trailerUrl);

  factory MovieV2.fromJson(String source) =>
      MovieV2.fromMap(jsonDecode(source) as DataMap);

  MovieV2.fromMap(DataMap dataMap)
      : this(
      dataMap["id"] ?? 0,
      dataMap["title"] ?? "",
      dataMap["apiFilmId"] ?? "",
      dataMap["bannerUrl"] ?? "",
      dataMap["duration"] ?? 0,
      dataMap["graphicUrl"] ?? "",
      dataMap["apiFilmType"] ?? "",
      dataMap["apiRating"] ?? "",
      dataMap["apiCaptionType"] ?? "",
      dataMap["apiRatingFormat"] ?? "",
      dataMap["apiGenreName"] ?? "",
      dataMap["openingDate"] ?? "",
      dataMap["synopsis"] ?? "",
      dataMap["synopsisEn"] ?? "",
      dataMap["titleEn"] ?? "",
      dataMap["trailerUrl"] ?? ""
  );

}