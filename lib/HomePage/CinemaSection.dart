import 'package:flutter/material.dart';
import 'package:learning_flutter/HomePage/OnScreenMovies.dart';
import 'package:learning_flutter/HomePage/UpComingMovie.dart';

import '../Model/MovieV2.dart';

class CinemaSection extends StatefulWidget {
  final List<MovieV2> upComingMovies;
  final List<MovieV2> onScreenMovies;

  const CinemaSection({super.key, required this.upComingMovies, required this.onScreenMovies});

  @override
  State<StatefulWidget> createState() => _CinemaSectionState();
}

class _CinemaSectionState extends State<CinemaSection> {
  late List<MovieV2> upComingMovies;
  late List<MovieV2> onScreenMovies;
  late ScrollController upComingScrollController;
  late ScrollController onScreenScrollController;

  @override
  void initState() {
    // TODO: implement initState
    upComingMovies = widget.upComingMovies;
    onScreenMovies = widget.onScreenMovies;
    if (upComingMovies.isNotEmpty) {
      upComingScrollController = ScrollController();
    }
    if (onScreenMovies.isNotEmpty) {
      onScreenScrollController = ScrollController();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UpComingMovies(movies: upComingMovies, scrollController: upComingScrollController),
          const SizedBox(
            height: 30,
          ),
          OnScreenMovies(movies: onScreenMovies, scrollController: onScreenScrollController),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
