import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'features/data/datasources/movie_datasource.dart';
import 'features/data/repositories/movie_repository_impl.dart';
import 'features/domain/repositories/movie_repository.dart';
import 'features/domain/usecases/get_movie_detail_usecase.dart';
import 'features/domain/usecases/get_similar_movies_usecase.dart';
import 'features/presentation/provider/movie_detail_notifier.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(() => MovieDetailNotifier(
        getMovieDetail: locator(),
        getSimilarMovies: locator(),
      ));

  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetSimilarMovies(locator()));

  locator.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
        datasource: locator(),
      ));

  locator.registerLazySingleton<MovieDatasource>(
      () => MovieDatasourceImpl(client: locator()));

  locator.registerLazySingleton(() => http.Client());
}
