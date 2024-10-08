import 'dart:convert';

import 'package:adoptive_calendar/adoptive_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:learning_flutter/HomePage/ScheduleView.dart';
import 'package:learning_flutter/Model/CinemaV2.dart';
import 'package:learning_flutter/Model/MovieV2.dart';
import 'package:learning_flutter/core/utils/AppCache.dart';
import 'package:learning_flutter/cubit/showtime/cinema_v2_bloc.dart';

import '../Model/City.dart';
import '../Model/ScheduleV2.dart';

class ScheduleMoviePage extends StatefulWidget {
  final MovieV2 movie;

  const ScheduleMoviePage({super.key, required this.movie});

  @override
  State<StatefulWidget> createState() => ScheduleMoviePageState();
}

class ScheduleMoviePageState extends State<ScheduleMoviePage> {
  late MovieV2 movie = widget.movie;

  List<City?> cities = [];

  late DateTime selectedDate;

  late City selectedCity;

  late String dateStr = "Select Date";

  late List<CinemaV2> cinemas = [];

  final bloc = CinemaV2Bloc();

  // Future<void> reloadData() async {
  //   String api = '$HOST$GET_SCHEDULE_BY_MOVIE?';
  //   String time = "${selectedDate.millisecondsSinceEpoch}";
  //   String cityId = "${selectedCity.apiId}";
  //   String apiFilmId = movie.apiFilmId;
  //   api =
  //       api + "time=${time}" + "&cityId=${cityId}" + "&apiFilmId=${apiFilmId}";
  //   try {
  //     var cinemaResp = await http.get(Uri.parse(api));
  //     if (cinemaResp.statusCode == 200) {
  //       List<dynamic> tempData = jsonDecode(cinemaResp.body);
  //       cinemas = tempData.map((e) {
  //         var dataMap = e;
  //         return CinemaV2.fromMap(dataMap);
  //       }).toList();
  //
  //       for (CinemaV2 cinema in cinemas) {
  //         String cineName = cinema.name;
  //         print(cineName + "\n ${cinema.cityName}");
  //         for (ScheduleV2 schedule in cinema.schedules) {
  //           print(schedule.showTimeDuration);
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    cities = AppCache.cities;
    selectedCity = cities.first!;
    selectedDate = DateTime.now();
    setDateStr();
    bloc.eventController.sink.add(CinemaV2UpdateEvent("${selectedDate.millisecondsSinceEpoch}",
        "${selectedCity.apiId}", "${movie.apiFilmId}"));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dateSection(),
          SizedBox(
            height: 30,
          ),
          StreamBuilder<CinemaV2State>(
            stream: bloc.stateController.stream,
            initialData: bloc.state,
            builder: (context, AsyncSnapshot<CinemaV2State> snapshot) {
              print("Date - ${selectedDate} City - ${selectedCity.name} : ${snapshot.data?.cinemas.length}");
              List<CinemaV2> cinemas = List.from(snapshot.data!.cinemas ?? []);
              if (cinemas.isNotEmpty) {
                return ScheduleView(cinemas: cinemas); // Pass the new list
              } else {
                return Center(
                  child: CircularProgressIndicator(color: Colors.amber),
                );
              }
            },
          ),
          // FutureBuilder(
          //     future: reloadData(),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.done) {
          //         return StreamBuilder<CinemaState>(
          //           stream: bloc.stateController.stream,
          //           initialData: bloc.state,
          //           builder: (context, AsyncSnapshot<CinemaState> snapshot) {
          //             return ScheduleView(cinemas: snapshot.data!.cinemas);
          //           },
          //         );
          //           // ScheduleView(cinemas: cinemas);
          //       } else {
          //         return Center(
          //           child: CircularProgressIndicator(color: Colors.amber),
          //         );
          //       }
          //     })
        ],
      ),
    );
  }

  Widget dateSection() {
    return Flex(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      direction: Axis.horizontal,
      children: [
        // date section
        GestureDetector(
          onTap: () {
            dialogDatePicker(context);
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(4.0)
            ),
            alignment: Alignment.topLeft,
            child: Wrap(
              children: [
                const Icon(
                  Icons.calendar_month,
                  color: Colors.amber,
                  size: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  dateStr,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.amber,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        // Drop down city
        Container(
            alignment: Alignment.topRight,
            child: Wrap(
              children: [
                cities.isNotEmpty ? DropdownButton(
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value!;
                      bloc.eventController.sink.add(CinemaV2UpdateEvent("${selectedDate.millisecondsSinceEpoch}",
                          "${selectedCity.apiId}", "${movie.apiFilmId}"));
                    });
                  },
                  icon: const Icon(Icons.arrow_drop_down_sharp,
                      color: Colors.amber, size: 30),
                  value: selectedCity,
                  items: cities.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      onTap: () {},
                      child: Text(
                        e?.name ?? "No data",
                        style: const TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    );
                  }).toList(),
                ) : const CircularProgressIndicator()
              ],
            ))
      ],
    );
  }

  Future<void> dialogDatePicker(BuildContext context) async {
    selectedDate = await showDialog(
          context: context,
          builder: (context) {
            return AdoptiveCalendar(
              action: true,
              datePickerOnly: true,
              initialDate: selectedDate,
              barForegroundColor: Colors.tealAccent,
              fontColor: Colors.amber,
            );
          });

    setState(() {
      bloc.eventController.sink.add(CinemaV2UpdateEvent("${selectedDate.millisecondsSinceEpoch}", "${selectedCity.apiId}",
          "${movie.apiFilmId}"));
      setDateStr();
    });
  }

  setDateStr() {
    	DateFormat format = DateFormat("EEEE,MMM dd yyyy");
      dateStr = format.format(selectedDate);
  }
}
