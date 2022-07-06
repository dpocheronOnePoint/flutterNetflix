import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutternetflix/models/movie.dart';
import 'package:flutternetflix/repositories/data_repository.dart';
import 'package:flutternetflix/ui/widgets/action_button.dart';
import 'package:flutternetflix/ui/widgets/movie_info.dart';
import 'package:flutternetflix/utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  Movie? updatedMovie;

  @override
  void initState() {
    super.initState();
    getMovieDetails();
  }

  void getMovieDetails() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    Movie movie = await dataProvider.getMovieDetails(movie: widget.movie);
    setState(() {
      updatedMovie = movie;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
      ),
      body: updatedMovie == null
          ? Center(
              child: SpinKitFadingCircle(color: kPrimaryColor, size: 20),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Container(
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.red,
                  ),
                  MovieInfo(movie: updatedMovie!),
                  const SizedBox(height: 10),
                  ActionButton(
                      label: 'Lecture',
                      icon: Icons.play_arrow,
                      bgColor: Colors.white,
                      color: kBackgroundColor),
                  const SizedBox(height: 20),
                  ActionButton(
                      label: 'Télécharger',
                      icon: Icons.download,
                      bgColor: Colors.grey.withOpacity(0.3),
                      color: Colors.white)
                ],
              ),
            ),
    );
  }
}
