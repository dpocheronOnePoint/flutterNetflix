import 'package:flutter/material.dart';
import 'package:flutternetflix/models/movie.dart';
import 'package:google_fonts/google_fonts.dart';

import 'movie_card.dart';

class MovieCategory extends StatelessWidget {
  // Attributes
  final String title;
  final List<Movie> movieList;
  final double imageHeight;
  final double imageWidth;

  const MovieCategory(
      {Key? key,
      required this.title,
      required this.movieList,
      required this.imageHeight,
      required this.imageWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(
          title,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: imageHeight,
          child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    width: imageWidth,
                    margin: const EdgeInsets.only(right: 8),
                    color: Colors.grey,
                    child: movieList.isEmpty
                        ? Center(
                            child: Text(index.toString()),
                          )
                        : MovieCard(movie: movieList[index]));
              }),
        ),
      ],
    );
  }
}
