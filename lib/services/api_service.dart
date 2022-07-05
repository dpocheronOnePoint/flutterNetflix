import 'package:flutternetflix/services/api.dart';
import 'package:dio/dio.dart';

import '../models/movie.dart';

class APIService {
  final API api = API();
  final Dio dio = Dio();

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    String _url = api.baseURL + path;

    // Global params for all request
    Map<String, dynamic> queryParameters = {
      'api_key': api.apiKey,
      'language': 'fr-FR'
    };

    // Check if request contains params and add its
    if (params != null) {
      queryParameters.addAll(params);
    }

    final response = await dio.get(_url, queryParameters: queryParameters);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getPopularMovies({required int pageNumber}) async {
    Response response =
        await getData('/movie/popular', params: {'page': pageNumber});

    if (response.statusCode == 200) {
      Map data = response.data;
      List<dynamic> results = data['results'];
      List<Movie> movies = [];
      for (Map<String, dynamic> json in results) {
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      }
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getNowPlayingMovies({required int pageNumber}) async {
    Response response =
        await getData('/movie/now_playing', params: {'page': pageNumber});

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getUpcomingMovies({required int pageNumber}) async {
    Response response =
        await getData('/movie/upcoming', params: {'page': pageNumber});

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();
      return movies;
    } else {
      throw response;
    }
  }
}
