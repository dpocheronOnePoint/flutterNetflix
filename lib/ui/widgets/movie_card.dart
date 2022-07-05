// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutternetflix/models/movie.dart';
import 'package:flutternetflix/ui/screens/movie_details_screen.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MovieDetailsScreen(movie: movie);
              },
            ),
          );
        },
        child: Image.network(movie.posterURL(), fit: BoxFit.cover));

    // return CachedNetworkImage(
    //   imageUrl: movie.posterURL(),
    //   fit: BoxFit.cover,
    //   errorWidget: (context, url, error) => const Center(
    //     child: Icon(Icons.error),
    //   ),
    // );
  }
}
