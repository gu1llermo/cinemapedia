import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';

final nowPlayingMoviesProvider =
    NotifierProvider<MoviesNotifier, List<Movie>>(MoviesNotifier.new);

class MoviesNotifier extends Notifier<List<Movie>> {
  int currentPage = 0;

  @override
  List<Movie> build() {
    return [];
  }

  Future<void> loadNextPage() async {
    currentPage++;
    final movieRepository = ref.read(movieRepositoryProvider);

    final List<Movie> movies =
        await movieRepository.getNowPlaying(page: currentPage);
    state = [...state, ...movies];
  }
}
