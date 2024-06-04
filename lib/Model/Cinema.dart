import 'dart:convert';
import 'dart:ffi';

import 'package:learning_flutter/core/utils/typedef.dart';

class Cinema {
  final Long id;
  final String name;
  final String slug;
  final String city;
  final String image;
  final String address;

  const Cinema({required this.id, required this.name, required this.slug, required this.city, required this.address, required this.image});

  factory Cinema.fromJson(String source) => Cinema.fromMap(jsonDecode(source) as DataMap);

  Cinema.fromMap(DataMap dataMap) : this (
    id : dataMap['id'] as Long,
    name : dataMap['name'] as String,
    slug : dataMap['slug'] as String,
    city : dataMap['city'] as String,
    image : dataMap['image'] as String,
    address : dataMap['address'] as String,
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
