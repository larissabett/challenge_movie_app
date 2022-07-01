import 'package:dartz/dartz.dart';
import '../../../common/failure.dart';
import '../entities/movie_details.dart';
import '../repositories/movie_repository.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute() {
    return repository.getMovieDetail();
  }
}
