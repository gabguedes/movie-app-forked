import 'dart:convert';

import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://api.themoviedb.org/3/';
const key = '?api_key=$apiKey';

class ApiServices {
  Future<Result> getTopRatedMovies() async {
    const endpoint = 'movie/top_rated';
    final url = Uri.parse('$baseUrl$endpoint$key');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Result.fromJson(json);
    }
    throw Exception('Ocorreu um erro');
  }

  Future<Result> getNowPlayingMovies() async {
    const endpoint = 'movie/now_playing';
    final url = Uri.parse('$baseUrl$endpoint$key');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Result.fromJson(json);
    }
    throw Exception('Ocorreu um erro');
  }

  Future<Result> getPopularMovies() async {
    const endpoint = 'movie/popular';
    final url = Uri.parse('$baseUrl$endpoint$key');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Result.fromJson(json);
    }
    throw Exception('Ocorreu um erro');
  }

  Future<Result> getUpcomingMovies() async {
    const endpoint = 'movie/upcoming';
    final url = Uri.parse('$baseUrl$endpoint$key');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Result.fromJson(json);
    }
    throw Exception('Ocorreu um erro');
  }

  Future<MovieDetailModel> getMovieDetail({required int movieId}) async{
    final endpoint = 'movie/$movieId';
    final url = Uri.parse('$baseUrl$endpoint$key');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return MovieDetailModel.fromJson(json);
    }
    throw Exception('Ocorreu um erro');
  }
}
