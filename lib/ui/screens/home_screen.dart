import 'package:flutter/material.dart';
import 'package:flutternetflix/repositories/data_repository.dart';
import 'package:flutternetflix/ui/widgets/movie_card.dart';
import 'package:flutternetflix/ui/widgets/movie_category.dart';
import 'package:flutternetflix/utils/constant.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          leading: Image.asset('assets/images/netflix_logo_2.png'),
        ),
        body: ListView(children: [
          SizedBox(
              height: 500,
              child: dataProvider.popularMovieList.isEmpty
                  ? const Center()
                  : MovieCard(movie: dataProvider.popularMovieList.first)),
          MovieCategory(
              title: 'Les tendances actuelles',
              movieList: dataProvider.popularMovieList,
              imageHeight: 160,
              imageWidth: 110,
              callBack: dataProvider.getPopularMovies),
          MovieCategory(
              title: 'Actuellement au cinéma',
              movieList: dataProvider.nowPlayingMovieList,
              imageHeight: 320,
              imageWidth: 220,
              callBack: dataProvider.getNowPlayingMovies),
          MovieCategory(
              title: 'Bientôt disponible',
              movieList: dataProvider.upcomingMovieList,
              imageHeight: 160,
              imageWidth: 110,
              callBack: dataProvider.getUpcomingMovies),
        ]));
  }
}
