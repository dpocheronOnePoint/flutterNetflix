// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutternetflix/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(movie.posterURL(), fit: BoxFit.cover);

    // return CachedNetworkImage(
    //   imageUrl: movie.posterURL(),
    //   fit: BoxFit.cover,
    //   errorWidget: (context, url, error) => const Center(
    //     child: Icon(Icons.error),
    //   ),
    // );
  }
}
