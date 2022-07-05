import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutternetflix/models/movie.dart';
import 'package:flutternetflix/services/api_service.dart';

class DataRepository with ChangeNotifier {
  final APIService apiService = APIService();
  final List<Movie> _popularMovieList = [];
  int popularMoviePageIndex = 1;
  bool wsAlreadyInProgress = false;
  final List<Movie> _nowPlayoingMovieList = [];
  int nowPlayingMoviePageIndex = 1;

  // Getters
  List<Movie> get popularMovieList => _popularMovieList;
  List<Movie> get nowPlayingMovieList => _nowPlayoingMovieList;

  Future<void> getPopularMovies() async {
    if (!wsAlreadyInProgress) {
      wsAlreadyInProgress = true;
      print("WS Calls !");
      try {
        List<Movie> movies = await apiService.getPopularMovies(
            pageNumber: popularMoviePageIndex);
        _popularMovieList.addAll(movies);
        popularMoviePageIndex++;
        notifyListeners();
        wsAlreadyInProgress = false;
      } on Response catch (response) {
        print("Error: ${response.statusCode}");
        wsAlreadyInProgress = false;
        rethrow;
      }
    }
  }

  Future<void> getNowPlayingMovies() async {
    if (!wsAlreadyInProgress) {
      wsAlreadyInProgress = true;
      try {
        List<Movie> movies = await apiService.getNowPlayingMovies(
            pageNumber: nowPlayingMoviePageIndex);
        _nowPlayoingMovieList.addAll(movies);
        nowPlayingMoviePageIndex++;
        notifyListeners();
        wsAlreadyInProgress = false;
      } on Response catch (response) {
        print("Error: ${response.statusCode}");
        wsAlreadyInProgress = false;
        rethrow;
      }
    }
  }

  Future<void> initData() async {
    await getPopularMovies();
    await getNowPlayingMovies();
  }
}
