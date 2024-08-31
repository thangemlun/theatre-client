import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../Model/CinemaV2.dart';
import '../../Model/ScheduleV2.dart';
import '../../core/utils/constant.dart';

import 'package:http/http.dart' as http;
part 'cinema_v2_event.dart';
part 'cinema_v2_state.dart';

class CinemaV2Bloc extends Bloc<CinemaV2Event, CinemaV2State> {

  var state = CinemaV2InitialState([]);

	final eventController = StreamController<CinemaV2Event>();
  final stateController = StreamController<CinemaV2State>();


  CinemaV2Bloc(): super(CinemaV2InitialState([])) {
    eventController.stream.listen((event) {
      if (event is CinemaV2UpdateEvent) {
        // TODO: implement event handler
        List<CinemaV2> cinemas = [];
        getScheduleForCinema(event).then((value) {
          cinemas = value;
          print("cinema size : ${cinemas.length}");
          state = CinemaV2InitialState(cinemas);
          stateController.sink.add(state);
        });
      }
    });
  }

  Future<List<CinemaV2>> getScheduleForCinema(CinemaV2Event event) async{
    String api = '$HOST$GET_SCHEDULE_BY_MOVIE?';
    String time = event.time;
    String cityId = event.citiId;
    String apiFilmId = event.apiFilmId;
    List<CinemaV2> cinemas = [];
    api =
        api + "time=${time}" + "&cityId=${cityId}" + "&apiFilmId=${apiFilmId}";
    try {
      var cinemaResp = await http.get(Uri.parse(api));
      if (cinemaResp.statusCode == 200) {
        List<dynamic> tempData = jsonDecode(cinemaResp.body);
        cinemas = tempData.map((e) {
          var dataMap = e;
          return CinemaV2.fromMap(dataMap);
        }).toList();

        for (CinemaV2 cinema in cinemas) {
          String cineName = cinema.name;
          print(cineName + "\n ${cinema.cityName}");
          for (ScheduleV2 schedule in cinema.schedules) {
            print(schedule.showTimeDuration);
          }
        }
      }
    } catch (e) {
      print(e);
    }
    return cinemas;
  }

}
