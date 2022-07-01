import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String nameMovie;
  final String yearMovie;
  final List<int> genreMovie;
  final String imageMovie;

  Movie({
    required this.nameMovie,
    required this.yearMovie,
    required this.genreMovie,
    required this.imageMovie,
  });

  @override
  List<Object?> get props => [
        nameMovie,
        yearMovie,
        genreMovie,
        imageMovie,
      ];
}
