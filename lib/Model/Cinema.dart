import 'dart:convert';
import 'dart:ffi';

import 'package:learning_flutter/core/utils/typedef.dart';

class Cinema {
  final int id;
  final String name;
  final String slug;
  final String city;
  final String image;
  final String address;

  const Cinema({required this.id, required this.name, required this.slug, required this.city, required this.address, required this.image});

  factory Cinema.fromJson(String source) => Cinema.fromMap(jsonDecode(source) as DataMap);

  Cinema.fromMap(DataMap dataMap) : this (
    id : dataMap["id"],
    name : dataMap["name"] != null ? dataMap["name"] : "",
    slug : dataMap["slug"] != null ? dataMap["slug"] : "",
    city : dataMap["city"] != null ? dataMap["city"] : "",
    image : dataMap["image"] != null ? dataMap["image"] : "",
    address : dataMap["address"] != null ? dataMap["address"] : "",
  );
  
  DataMap toMap() => {
      'id' : id,
      'name' : name,
      'slug' : slug,
      'city' : city,
      'image' : image,
      'address' : address
  };

  String toJson() => jsonEncode(toMap());
}
