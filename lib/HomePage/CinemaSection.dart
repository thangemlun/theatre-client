import 'package:flutter/material.dart';

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
                        children: movieList
                            .map((e) {
                              return MoviePoster(movie: e);
                            })
                            .toList()),
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
            onTap: (){
              showDialog(
                  context: context,
                  builder: (context) {
                return Dialog(
                  child: Container(
                    child: Scaffold(
                      body: CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            centerTitle: true,
                            excludeHeaderSemantics: true,
                            expandedHeight: MediaQuery.of(context).size.height,
                            flexibleSpace: FlexibleSpaceBar(
                              collapseMode: CollapseMode.parallax,
                              background: Container(
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
                                      image: NetworkImage(movie.poster),
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.fill,
                                      matchTextDirection: true),
                                ),
                              ),
                            ),
                            title: Text(movie.name, style: const TextStyle(
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                          SliverList(delegate: SliverChildListDelegate([
                            SizedBox(height: 20,),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 20,),
                                      Text("Ngày ra mắt : "
                                          "${movie.releaseDate.day}-${movie.releaseDate.month}-${movie.releaseDate.year}"),
                                      SizedBox(width: 20,),
                                      Text("Thời lượng : ${movie.duration}")
                                    ],
                                  ), SizedBox(height: 20,)
                                  , Text("Nội dung : ${movie.seo_description}"), SizedBox(height: 20,)
                                ]
                              ),
                            ),
                          ]))
                        ],
                      )
                    ),
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
