import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learning_flutter/HomePage/CinemaSection.dart';
import 'package:learning_flutter/Model/Movie.dart';
import 'package:learning_flutter/core/utils/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  late List<Movie> newestMovies = [];
  final List<String> movieTypes = ["Cinema", "Television"];

  String selectedType = "Cinema";

  Future<void> trendingListHome() async {
    switch (selectedType) {
      case "Cinema":
        {
          var movieResp =
              await http.get(Uri.parse(THEATRE_HOST + GET_TRENDING_MOVIES));
          if (movieResp.statusCode == 200) {
            try {
              List<dynamic> tempData = jsonDecode(movieResp.body);
              newestMovies = tempData.map((e) {
                var dataMap = e;
                return Movie.fromMap(dataMap);
              }).toList();
            } catch(e) {
              print(e);
            }
          }
          break;
        }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: true,
          excludeHeaderSemantics: true,
          expandedHeight: MediaQuery.of(context).size.height,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: FutureBuilder(
              future: trendingListHome(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CarouselSlider(
                      options: CarouselOptions(
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                      ),
                      items: newestMovies.map((e) {
                        return Builder(builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                // gradient: LinearGradient(colors: [Color()]),
                                color: Colors.white,
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
                                    alignment: Alignment.center,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.3),
                                        BlendMode.darken),
                                    image: NetworkImage(e.poster),
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.fill,
                                    matchTextDirection: true),
                              ),
                            ),
                          );
                        });
                      }).toList());
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  );
                }
              },
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Trending 🔥",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8), fontSize: 16)),
              const SizedBox(width: 10),
              Container(
                height: 45,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(6)),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: DropdownButton(
                    onChanged: (value) {
                      setState(() {
                        selectedType = value!;
                      });
                    },
                    icon: const Icon(Icons.arrow_drop_down_sharp,
                        color: Colors.amber, size: 30),
                    value: selectedType,
                    items: movieTypes.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        onTap: () {},
                        child: Text(
                          e,
                          style: const TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              width: MediaQuery.of(context).size.width,
              child:
              selectedType == "Cinema" && (newestMovies.length > 0) ? CinemaSection(movies: newestMovies) : Text(selectedType),
            )
          ]),
        ),
      ],
    ));
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
          Container(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.name,
              style: TextStyle(
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
