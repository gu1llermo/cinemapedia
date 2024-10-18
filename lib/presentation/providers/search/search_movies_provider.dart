import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) {
  return '';
});

final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);

  return SearchedMoviesNotifier(
      searchMovies: movieRepository.searchMovie, ref: ref);
});

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  SearchedMoviesNotifier(
      {required Future<List<Movie>> Function(String) searchMovies,
      required this.ref})
      : _searchMovies = searchMovies,
        super([]);
  final SearchMoviesCallback _searchMovies;
  final Ref ref;

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final searchQuery = ref.read(searchQueryProvider);
    if (searchQuery.trim() == query.trim()) {
      return state;
    }

    ref.read(searchQueryProvider.notifier).update((state) => query);

    final movies = await _searchMovies(query);
    state = movies;

    return movies;
  }
}
