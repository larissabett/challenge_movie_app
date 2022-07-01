import 'package:dartz/dartz.dart';
import '../../../common/exception.dart';
import '../../../common/failure.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/entities/movie_list.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_datasource.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieDatasource datasource;

  MovieRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail() async {
    try {
      final result = await datasource.getMovieDetail();
      return Right(result.toEntity());
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getSimilarMovies() async {
    try {
      final result = await datasource.getSimilarMovies();
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      throw ServerException();
    }
  }
}
