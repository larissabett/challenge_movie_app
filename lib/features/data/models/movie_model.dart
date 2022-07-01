import 'package:equatable/equatable.dart';
import '../../domain/entities/movie_list.dart';

class MovieModel extends Equatable {
  final String nameMovie;
  final String yearMovie;
  final List<int> genreMovie;
  final String imageMovie;

  MovieModel({
    required this.nameMovie,
    required this.yearMovie,
    required this.genreMovie,
    required this.imageMovie,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        nameMovie: json["original_title"],
        yearMovie: json["release_date"],
        genreMovie: List<int>.from(json["genre_ids"].map((x) => x)),
        imageMovie: json["poster_path"],
      );

  Map<String, dynamic> toJson() => {
        'nameMovie': nameMovie,
        yearMovie: yearMovie,
        'genreMovie': List<dynamic>.from(genreMovie.map((x) => x)),
        'imageMovie': imageMovie,
      };

  Movie toEntity() {
    return Movie(
      nameMovie: nameMovie,
      yearMovie: yearMovie,
      genreMovie: genreMovie,
      imageMovie: imageMovie,
    );
  }

  @override
  List<Object?> get props => [
        nameMovie,
        yearMovie,
        genreMovie,
        imageMovie,
      ];
}
