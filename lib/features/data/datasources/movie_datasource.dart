import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../common/exception.dart';
import '../models/movie_detail_model.dart';
import '../models/movie_model.dart';
import '../models/movie_response_model.dart';

abstract class MovieDatasource {
  Future<MovieDetailModel> getMovieDetail();
  Future<List<MovieModel>> getSimilarMovies();
}

class MovieDatasourceImpl implements MovieDatasource {
  static const API_KEY = "9f6bb4e7c879708fa12e2032c344abe8";
  static const BASE_URL = "https://api.themoviedb.org/3";
  final http.Client client;
  var id = 122;

  MovieDatasourceImpl({
    required this.client,
  });

  @override
  Future<MovieDetailModel> getMovieDetail() async {
    final response =
        await client.get(Uri.parse("$BASE_URL/movie/$id?api_key=$API_KEY"));
    if (response.statusCode == 200) {
      var detail = MovieDetailModel.fromJson(json.decode(response.body));
      return detail;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getSimilarMovies() async {
    final response = await client
        .get(Uri.parse('$BASE_URL/movie/$id/similar?api_key=$API_KEY'));
    if (response.statusCode == 200) {
      var r = MovieResponseModel.fromJson(json.decode(response.body)).movieList;
      return r;
    }
    throw ServerException();
  }
}
