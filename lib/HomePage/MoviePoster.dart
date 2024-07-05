import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learning_flutter/HomePage/MovieDetail.dart';
import 'package:learning_flutter/HomePage/ScheduleMoviePage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Model/MovieV2.dart';

class MoviePoster extends StatelessWidget {
  final MovieV2 movie;
  final String type;

  const MoviePoster({super.key, required this.movie, required this.type});

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
                        width: 1000,
                        child: Scaffold(
                            body: Stack(
                              children: [
                                Opacity(
                                  opacity: 0.2,
                                  child: Image.network(
                                    movie.bannerUrl,
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
                                                    movie.graphicUrl,
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
                                                    launchUrl(Uri.parse(movie.trailerUrl));
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
                                              SizedBox(height: 20,),
                                              Text(movie.title,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w500,
                                                ),),
                                              SizedBox(height: 20,),
                                              MovieDetail(movie: movie),
                                              const SizedBox(height: 20,),
                                              type == "Upcoming" ? SizedBox(height: 5,) : Divider(height: 20,thickness: 2.0, color: Colors.amber),
                                              type == "Upcoming" ? SizedBox(height: 5,) : ScheduleMoviePage(movie: movie)
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
                  image: NetworkImage(movie.graphicUrl),
                  fit: BoxFit.fill,
                  opacity: 0.6
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.title,
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