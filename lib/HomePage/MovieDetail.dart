import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Model/MovieV2.dart';

class MovieDetail extends StatelessWidget{

  final MovieV2 movie;

  const MovieDetail({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
            children: [
              Container(
                width: 50,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
                color: getRatingFormat(movie).withOpacity(0.8)),
                child: Center(child: Text(movie.apiRating, style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16
                ),),),
              ),
              SizedBox(width: 20,),
            ],
          ),
        const SizedBox(height: 20,),
        Wrap(
            direction: Axis.horizontal,
            children: [
              ColumnDetail(itemType: "Ngày chiếu", itemContent: getDateScreen(movie.openingDate)),
              SizedBox(width: 30,),
              ColumnDetail(itemType: "Thể loại", itemContent: movie.apiGenreName),
              SizedBox(width: 30,),
              ColumnDetail(itemType: "Công nghệ", itemContent: movie.apiFilmType),
              SizedBox(width: 30,),
            ],
        ),
        SizedBox(height: 30,),
        // content of the movie
        ColumnDetail(itemType: "Nội dung", itemContent: movie.synopsisEn),
        SizedBox(height: 30,),
        Row(
          children: [
            Text("Thời lượng : ${movie.duration} phút",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),),
          ],
        )
      ],
    );
  }

  String getDateScreen(String date) {
    DateFormat format = DateFormat("yyyy-MM-dd hh:mm:ss");
    DateTime time = format.parse(date);
    return '${time.day}/${time.month}/${time.year}';
  }

  Color getRatingFormat(MovieV2 movie) {
    return movie.apiRating == "P" ? Colors.green : Colors.amber;
  }
}

class ColumnDetail extends StatelessWidget {
  final String itemType;
  final String itemContent;

  const ColumnDetail({super.key, required this.itemType, required this.itemContent});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(itemType, style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w100
        ),),
        Text(itemContent, style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500
        ),)
      ],
    );
  }

}