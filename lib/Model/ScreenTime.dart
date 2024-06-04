import 'dart:convert';
import 'package:learning_flutter/core/utils/typedef.dart';

class ScreenTime {
  final String? screen;
  final List<String>? times;
  
  const ScreenTime({required this.screen, required this.times});

  factory ScreenTime.fromJson(String src) => 
    ScreenTime.fromMap(jsonDecode(src) as DataMap);
    
  ScreenTime.fromMap(DataMap map) : this(
    screen: map['screen'] as String,
    times: map['times'] as List<String>
  );

  DataMap toMap() => {
      'screen' : screen,
      'times' : times
  };

  String toJson() => jsonEncode(toMap());

}
