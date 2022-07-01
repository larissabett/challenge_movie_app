import 'package:equatable/equatable.dart';
import 'movie_model.dart';

class MovieResponseModel extends Equatable {
  final List<MovieModel> movieList;
  MovieResponseModel({required this.movieList});

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) =>
      MovieResponseModel(
        movieList: List<MovieModel>.from((json['results'] as List)
            .map((e) => MovieModel.fromJson(e))
            .where((element) => element.imageMovie != null)),
      );

  Map<String, dynamic> toJson() => {
        'results': List<dynamic>.from(movieList.map((e) => e.toJson())),
      };

  @override
  List<Object?> get props => [movieList];
}
