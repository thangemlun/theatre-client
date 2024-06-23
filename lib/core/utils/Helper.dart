import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/City.dart';

class Helper{
  static Future<bool> saveCacheCities(List<City> data) async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setStringList("cities", data.map((e) {return e.toJson();}).toList());
  }

  static Future<List<String>?> getCities() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getStringList("cities");
  }
}