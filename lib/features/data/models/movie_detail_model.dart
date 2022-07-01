import 'package:equatable/equatable.dart';
import '../../domain/entities/movie_details.dart';

class MovieDetailModel extends Equatable {
  int movieId;
  String movieName;
  String movieImage;
  int movieLikes;
  double moviePopularity;

  MovieDetailModel({
    required this.movieId,
    required this.movieImage,
    required this.movieName,
    required this.movieLikes,
    required this.moviePopularity,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) =>
      MovieDetailModel(
        movieId: json["id"],
        movieImage: json["backdrop_path"],
        movieName: json["original_title"],
        movieLikes: json["vote_count"],
        moviePopularity: json["popularity"],
      );

  MovieDetail toEntity() {
    return MovieDetail(
      movieId: movieId,
      movieImage: movieImage,
      movieName: movieName,
      movieLikes: movieLikes,
      moviePopularity: moviePopularity,
    );
  }

  @override
  List<Object?> get props => [
        movieId,
        movieImage,
        movieName,
        movieLikes,
        moviePopularity,
      ];
}
