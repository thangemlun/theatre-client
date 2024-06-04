import 'dart:convert';
import 'dart:ffi';

import 'package:learning_flutter/Model/ScreenTime.dart';
import 'package:learning_flutter/core/utils/typedef.dart';

class ShowTime {
  final int? id;
  final String? date;
  final Map<String, List<ScreenTime>>? time;
  final Long ?movie_id;
  final Long ?cinema_id;
  final String ?name;
  final String ?poster;
  final String ?duration;
  final String ?slug;

  const ShowTime({required this.id, required this.date, required this.time, required this.movie_id, required this.cinema_id, required this.name, required this.duration, required this.poster, required this.slug});

  factory ShowTime.fromJson(String source) => ShowTime.fromMap(jsonDecode(source) as DataMap);

  ShowTime.fromMap(DataMap dataMap) : this (
    id: dataMap['id'] as int,
    date: dataMap['date'] as String,
    time: dataMap['time'] as Map<String, List<ScreenTime>>,
    movie_id: dataMap['movie_id'] as Long,
    cinema_id: dataMap['cinema_id'] as Long,
    name: dataMap['name'] as String,
    poster: dataMap['poster'] as String,
    duration: dataMap['duration'] as String,
    slug: dataMap['slug'] as String
  );
  
  DataMap toMap() => {
      'id' : id,
      'date' : date,
      'time' : time,
      'movie_id' : movie_id,
      'cinema_id' : cinema_id,
      'name' : name,
      'poster' : poster,
      'duration' : duration,
      'slug' : slug
  };

  String toJson() => jsonEncode(toMap());

}
