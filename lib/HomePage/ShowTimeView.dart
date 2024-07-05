import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../Model/ScheduleV2.dart';

class ShowTimeView extends StatefulWidget {
  final List<ScheduleV2> schedules;

  const ShowTimeView({super.key, required this.schedules});

  @override
  State createState() => ShowTimeViewState();
}

class ShowTimeViewState extends State<ShowTimeView> {
  late List<ScheduleV2> showTimes = [];

  late ScrollController scrollShowTimeControl;

  @override
  void initState() {
    // TODO: implement initState
    showTimes = widget.schedules;
    if (showTimes.isNotEmpty) {
      scrollShowTimeControl = ScrollController();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 800,
      height: 40,
      margin: EdgeInsets.only(bottom: 4.0),
      child: showTimes.isNotEmpty
            ? Scrollbar(
              trackVisibility: true,
              thumbVisibility: true,
              interactive: true,
              thickness: 0.8,
              scrollbarOrientation: ScrollbarOrientation.bottom,
              controller: scrollShowTimeControl,
              child: AlignedGridView.count(
                  physics: ClampingScrollPhysics(),
                  controller: scrollShowTimeControl,
                  crossAxisCount: 1,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 5.0,
                  scrollDirection: Axis.horizontal,
                  // addAutomaticKeepAlives: true,
                  itemCount: showTimes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return showTimeDetail(showTimes[index]);
                  },

                ),
            )
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              ),
    );
  }

  Widget showTimeDetail(ScheduleV2 showTime) {
    return InkWell(
      child: Container(
          width: 120,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.white30)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  showTime.showTimeDuration,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
              )
            ],
          )),
    );
  }
}
