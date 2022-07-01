import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/state_enum.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/entities/movie_list.dart';
import '../provider/movie_detail_notifier.dart';
import '../widgets/back_button.dart';
import 'package:intl/intl.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({Key? key}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MovieDetailNotifier>(context, listen: false)
          .fetchMovieDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: backButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Consumer<MovieDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.movieState == RequestState.Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.movieState == RequestState.Loaded) {
            final movie = provider.movie;
            return SafeArea(
              child: MovieDetails(
                movie,
                provider.moviesList,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class MovieDetails extends StatefulWidget {
  final MovieDetail movie;
  final List<Movie> similarMovies;
  MovieDetails(this.movie, this.similarMovies);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  bool click = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://image.tmdb.org/t/p/w500/${widget.movie.movieImage}",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              _buildTitle(),
              _buildDetails(),
              const SizedBox(height: 15),
              _buildListOfMovies(),
            ],
          ),
        ),
      ],
    );
  }

  _buildTitle() {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black,
          spreadRadius: 100,
          blurRadius: 150,
        )
      ]),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
              child: Text(
                widget.movie.movieName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              color: Colors.white,
              onPressed: () {
                setState(() {
                  setState(() {
                    click = !click;
                  });
                });
              },
              icon: Icon(
                (click == false)
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
              ),
              iconSize: 28,
            ),
          )
        ],
      ),
    );
  }

  _buildDetails() {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          //likes
          Expanded(
            flex: 1,
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.favorite,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
                Text(widget.movie.movieLikes.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 12)),
                const Text(' Likes',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.contrast_outlined,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
                Text(widget.movie.moviePopularity.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 12)),
                const Text(' Popularity',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          ), // watched
        ],
      ),
    );
  }

  _buildListOfMovies() {
    return Expanded(
        child: ListView.builder(
      itemCount: widget.similarMovies.length,
      itemBuilder: createListItem,
    ));
  }

  Widget createListItem(context, index) {
    final movie = widget.similarMovies[index];
    return Column(
      children: [
        Card(
          color: Colors.black,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Image(
                    image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500/${movie.imageMovie}'),
                    width: 50,
                    height: 70),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.nameMovie,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(_yearFormater(movie.yearMovie),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12)),
                        const SizedBox(width: 7),
                        Text(movie.genreMovie.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 30, left: 20, right: 2),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 5,
          color: Colors.grey[900],
        ),
      ],
    );
  }

  _yearFormater(String yearMovie) {
    final formater = DateFormat('yyyy');
    return formater.format(DateTime.parse(yearMovie));
  }
}
