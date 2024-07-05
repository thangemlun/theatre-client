import 'package:flutter/material.dart';

import '../Model/MovieV2.dart';
import 'MoviePoster.dart';

class UpComingMovies extends StatelessWidget {

  final List<MovieV2> movies;
  final ScrollController scrollController;

  const UpComingMovies({super.key, required this.movies, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [const Padding(
        padding: EdgeInsets.only(left: 10.0, top: 15, bottom: 40),
        child: Text("Upcoming Movies", style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20
        )),
      ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 250,
          child: !(movies.isNotEmpty)
              ? const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          )
              : Scrollbar(
            trackVisibility: true,
            thumbVisibility: true,
            interactive: true,
            thickness: 3.0,
            scrollbarOrientation: ScrollbarOrientation.bottom,
            controller: scrollController,
            child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                children: movies.map((e) {
                  return MoviePoster(movie: e, type: "Upcoming",);
                }).toList()),
          ),
        ),
      ],
    );
  }

}