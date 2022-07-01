import 'package:flutter/cupertino.dart';
import '../../../common/state_enum.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/entities/movie_list.dart';
import '../../domain/usecases/get_movie_detail_usecase.dart';
import '../../domain/usecases/get_similar_movies_usecase.dart';

class MovieDetailNotifier extends ChangeNotifier {
  GetMovieDetail getMovieDetail;
  GetSimilarMovies getSimilarMovies;
  MovieDetailNotifier({
    required this.getMovieDetail,
    required this.getSimilarMovies,
  });

  late MovieDetail _movieDetail;
  MovieDetail get movie => _movieDetail;

  RequestState _movieState = RequestState.Empty;
  RequestState get movieState => _movieState;

  List<Movie> _movieList = [];
  List<Movie> get moviesList => _movieList;

  RequestState _listState = RequestState.Empty;
  RequestState get listState => _listState;

  Future<void> fetchMovieDetail() async {
    _movieState = RequestState.Loading;
    notifyListeners();

    final movieListResult = await getSimilarMovies.execute();

    final detailResult = await getMovieDetail.execute();
    detailResult.fold((failure) {
      _movieState = RequestState.Error;
      notifyListeners();
    }, (movie) {
      _movieDetail = movie;
      notifyListeners();
      _movieState = RequestState.Loaded;
      notifyListeners();
      movieListResult.fold((failure) {
        _listState = RequestState.Error;
      }, (movies) {
        _listState = RequestState.Loaded;
        _movieList = movies;
      });
    });
  }
}
