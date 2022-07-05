import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutternetflix/models/movie.dart';
import 'package:flutternetflix/repositories/data_repository.dart';
import 'package:flutternetflix/utils/constant.dart';
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
          : ListView(
              children: [
                Container(
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.red,
                )
              ],
            ),
    );
  }
}
