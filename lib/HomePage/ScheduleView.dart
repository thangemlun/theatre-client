import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learning_flutter/HomePage/ShowTimeView.dart';
import 'package:learning_flutter/Model/CinemaV2.dart';

import '../Model/ScheduleV2.dart';

class ScheduleView extends StatefulWidget {
  final List<CinemaV2> cinemas;

  const ScheduleView({super.key, required this.cinemas});

  @override
  State<StatefulWidget> createState() => ScheduleViewState();
}

class ScheduleViewState extends State<ScheduleView> {
  late List<CinemaV2> cinemas;
  late ScrollController cinemaScroller;

  @override
  void initState() {
    // TODO: implement initState
    cinemas = widget.cinemas;

    if (cinemas.isNotEmpty) {
      cinemaScroller = ScrollController();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return cinemas.isNotEmpty
        ? _renderSchedule(context)
        : const Center(
            child: Text("No data"),
          );
  }

  Widget _renderSchedule(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(4.0)
      ),
      child: ListView.builder(
          itemCount: cinemas.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return location(cinemas[index]);
          },
        ),
    );
  }

  Widget location(CinemaV2 cinemaV2) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      child: Wrap(children: [
        Row(
          children: [
            cinemaV2.logo.contains(".svg") ?
            SvgPicture.network(cinemaV2.logo) : Image.network(
              cinemaV2.logo,
              width: 40,
              height: 30,
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.vertical,
              children: [
                ColumnDetail(
                    itemType: cinemaV2.name,
                    itemContent: cinemaV2.address ?? ""),
              ],
            )
          ],
        ),
        SizedBox(height: 20,),
        ShowTimeView(schedules: cinemaV2.schedules),
        SizedBox(height: 20,),
        const Divider(thickness: 1.0, color: Colors.white30),
        // ShowTimeView(schedules: cinemaV2.schedules)
      ]),
    );
  }

  Widget showTimeDetail(ScheduleV2 showTime) {
    return InkWell(
      child: Container(
          width: 40,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.white30)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                  showTime.showTimeDuration,
                  style: const TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
            ],
          )),
    );
  }
}

class ColumnDetail extends StatelessWidget {
  final String itemType;
  final String itemContent;

  const ColumnDetail(
      {super.key, required this.itemType, required this.itemContent});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 650,
      padding: EdgeInsets.all(18.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            itemType,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w100,
            ),
          ),
          Tooltip(
            message: itemContent,
            child: Wrap(
              children: [
                Text(
                  itemContent,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
