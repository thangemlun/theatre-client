import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/Schedule.dart';

import 'package:http/http.dart' as http;

import '../core/utils/constant.dart';
import 'package:intl/intl.dart';

class ScheduleChannelPage extends StatefulWidget{
  final String channelId;

  const ScheduleChannelPage({super.key, required this.channelId});

  @override
  State<StatefulWidget> createState() => ScheduleChannelPageState();
}

class ScheduleChannelPageState extends State<ScheduleChannelPage>{

  late List<Schedule> schedules = [];

  Future<void> getSchedules() async {
    try {
      var schedulesResp =
      await http.get(Uri.parse("$HOST$GET_SCHEDULE_BY_CHANNEL_ID?_id=${widget.channelId}"));
      List<dynamic> tempData = jsonDecode(schedulesResp.body);
      if (schedulesResp.statusCode == 200) {
        schedules = await tempData.map((e) {
          var dataMap = e;
          return Schedule.fromMap(dataMap);
        }).toList();
      }
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(future: getSchedules(), builder: (context, snapShot) {
      return schedules.isNotEmpty ? Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.only(right: 100),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: schedules.isNotEmpty ? schedules.length : 0 ,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return (schedules.isNotEmpty) ?
                    getContentSchedule(schedules[index]) :
                    const CircularProgressIndicator();
                  }
              ),
            )
        ) : const CircularProgressIndicator();
    });
  }

  bool isLive(Schedule schedule) {
    DateTime now = DateTime.now();
    return (schedule.start_time.isBefore(now) && schedule.end_time.isAfter(now)) ;
  }

  Widget getContentSchedule(Schedule schedule) {
    Widget content = Text('${DateFormat("HH:mm").format(schedule.start_time)}   ${schedule.full_title} ',
      style:  const TextStyle(fontWeight: FontWeight.w500),);
    Widget liveTxt = (isLive(schedule)) ? const Text("Đang phát", style: TextStyle(
      color: Colors.white,
      backgroundColor: Colors.amber,
    ),) : const SizedBox(width: 0,) ;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        content,
        const SizedBox(width: 20),
        liveTxt
      ],);
  }

}

