import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final repository = ref.read(movieRepositoryProvider);

  return MovieMapNotifier(getMovie: repository.getMovieById);
});

/*
{
  '11111': Movie(),
  '22222': Movie(),
  '33333': Movie(),
}
*/

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback _getMovie;

  MovieMapNotifier({
    required GetMovieCallback getMovie,
  })  : _getMovie = getMovie,
        super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return; // si existe entonces no cargas nada

    final movie = await _getMovie(movieId);

    state = {...state, movieId: movie};
  }
}
