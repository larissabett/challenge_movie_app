import 'package:dartz/dartz.dart';
import '../../../common/failure.dart';
import '../entities/movie_list.dart';
import '../repositories/movie_repository.dart';

class GetSimilarMovies {
  final MovieRepository repository;
  GetSimilarMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getSimilarMovies();
  }
}
