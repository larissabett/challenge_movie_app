import 'package:dartz/dartz.dart';
import '../../../common/failure.dart';
import '../entities/movie_details.dart';
import '../entities/movie_list.dart';

abstract class MovieRepository {
  Future<Either<Failure, MovieDetail>> getMovieDetail();
  Future<Either<Failure, List<Movie>>> getSimilarMovies();
}
