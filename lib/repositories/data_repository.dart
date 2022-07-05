import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutternetflix/models/movie.dart';
import 'package:flutternetflix/services/api_service.dart';

class DataRepository with ChangeNotifier {
  final APIService apiService = APIService();

  // PopularMovies
  final List<Movie> _popularMovieList = [];
  int popularMoviePageIndex = 1;
  bool popularWsAlreadyInProgress = false;
  List<Movie> get popularMovieList => _popularMovieList;

  // NowPlayingMovies
  final List<Movie> _nowPlayoingMovieList = [];
  int nowPlayingMoviePageIndex = 1;
  bool nowPlayingWsAlreadyInProgress = false;
  List<Movie> get nowPlayingMovieList => _nowPlayoingMovieList;

  // UpcomingMovies
  final List<Movie> _upcomingMovieList = [];
  int upcomingMoviePageIndex = 1;
  bool upcomingWsAlreadyInProgress = false;
  List<Movie> get upcomingMovieList => _upcomingMovieList;

  Future<void> getPopularMovies() async {
    if (!popularWsAlreadyInProgress) {
      popularWsAlreadyInProgress = true;
      print("WS Calls !");
      try {
        List<Movie> movies = await apiService.getPopularMovies(
            pageNumber: popularMoviePageIndex);
        _popularMovieList.addAll(movies);
        popularMoviePageIndex++;
        notifyListeners();
        popularWsAlreadyInProgress = false;
      } on Response catch (response) {
        print("Error: ${response.statusCode}");
        popularWsAlreadyInProgress = false;
        rethrow;
      }
    }
  }

  Future<void> getNowPlayingMovies() async {
    if (!nowPlayingWsAlreadyInProgress) {
      nowPlayingWsAlreadyInProgress = true;
      try {
        List<Movie> movies = await apiService.getNowPlayingMovies(
            pageNumber: nowPlayingMoviePageIndex);
        _nowPlayoingMovieList.addAll(movies);
        nowPlayingMoviePageIndex++;
        notifyListeners();
        nowPlayingWsAlreadyInProgress = false;
      } on Response catch (response) {
        print("Error: ${response.statusCode}");
        nowPlayingWsAlreadyInProgress = false;
        rethrow;
      }
    }
  }

  Future<void> getUpcomingMovies() async {
    if (!upcomingWsAlreadyInProgress) {
      upcomingWsAlreadyInProgress = true;
      try {
        List<Movie> movies = await apiService.getUpcomingMovies(
            pageNumber: upcomingMoviePageIndex);
        _upcomingMovieList.addAll(movies);
        upcomingMoviePageIndex++;
        notifyListeners();
        upcomingWsAlreadyInProgress = false;
      } on Response catch (response) {
        print("Error: ${response.statusCode}");
        upcomingWsAlreadyInProgress = false;
        rethrow;
      }
    }
  }

  Future<void> initData() async {
    await getPopularMovies();
    await getNowPlayingMovies();
    await getUpcomingMovies();
  }
}
