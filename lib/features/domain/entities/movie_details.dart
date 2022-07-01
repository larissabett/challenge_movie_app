import 'package:equatable/equatable.dart';

class MovieDetail extends Equatable {
  final int movieId;
  final String movieImage;
  final String movieName;
  final int movieLikes;
  final double moviePopularity;

  MovieDetail({
    required this.movieId,
    required this.movieImage,
    required this.movieName,
    required this.movieLikes,
    required this.moviePopularity,
  });

  @override
  List<Object?> get props => [
        movieId,
        movieImage,
        movieName,
        movieLikes,
        moviePopularity,
      ];
}
