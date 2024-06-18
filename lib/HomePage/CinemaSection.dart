import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Model/Movie.dart';

class CinemaSection extends StatefulWidget {
  final List<Movie> movies;

  const CinemaSection({super.key, required this.movies});

  @override
  State<StatefulWidget> createState() => _CinemaSectionState();
}

class _CinemaSectionState extends State<CinemaSection> {
  late List<Movie> movieList;
  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    movieList = widget.movies;
    if (movieList != null && movieList.length > 0) {
      _scrollController = ScrollController();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10.0, top: 15, bottom: 40),
            child: Text("Upcoming Movies"),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: !(movieList != null && movieList.length > 0)
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
                    controller: _scrollController,
                    child: ListView(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        children: movieList.map((e) {
                          return MoviePoster(movie: e);
                        }).toList()),
                  ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  final Movie movie;

  const MoviePoster({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0), // Margin for spacing between posters
      width: 200,
      height: 300,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                        width: 700,
                        child: Scaffold(
                            body: Stack(
                          children: [
                            Opacity(
                              opacity: 0.2,
                              child: Image.network(
                                movie.poster,
                                height: 400,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SingleChildScrollView(
                              child: SafeArea(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 25),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Icon(
                                              Icons.arrow_back,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 120,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black12
                                                        .withOpacity(0.5),
                                                    blurRadius: 8,
                                                  )
                                                ]),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(
                                                movie.poster,
                                                height: 200,
                                                width: 180,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 50, top: 180),
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                color: Colors.amber.withOpacity(0.8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.amber
                                                        .withOpacity(0.8),
                                                    spreadRadius: 2,
                                                    blurRadius: 8,
                                                  )
                                                ]),
                                            child: GestureDetector(
                                              onTap: () {
                                                launchUrl(Uri.parse(movie.trailer));
                                              },
                                              child: Icon(Icons.play_arrow,
                                              color: Colors.white.withOpacity(0.8),
                                              size: 60,),
                                            ),

                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 30,),
                                    // Movie detail goes here
                                    Padding(padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(movie.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500,
                                        ),),
                                        const SizedBox(height: 20,),
                                        Text(movie.seo_description,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),),
                                        const SizedBox(height: 20,),
                                        Row(
                                          children: [
                                            Text("Thời lượng : ${movie.duration}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),),
                                          ],
                                        )
                                      ],
                                    ),
                                    )

                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                      ),
                    );
                  });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                  stops: [0.5, 1.0],
                ),
                image: DecorationImage(
                  image: NetworkImage(movie.poster),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
