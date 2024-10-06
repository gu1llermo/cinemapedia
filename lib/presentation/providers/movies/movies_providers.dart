import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';

final nowPlayingMoviesProvider =
    NotifierProvider<MoviesNotifier, List<Movie>>(() {
  return MoviesNotifier(requestType: RequestType.nowPlaying);
});

final popularMoviesProvider = NotifierProvider<MoviesNotifier, List<Movie>>(() {
  return MoviesNotifier(requestType: RequestType.popular);
});

final topRatedMoviesProvider =
    NotifierProvider<MoviesNotifier, List<Movie>>(() {
  return MoviesNotifier(requestType: RequestType.topRated);
});

final upcomingMoviesProvider =
    NotifierProvider<MoviesNotifier, List<Movie>>(() {
  return MoviesNotifier(requestType: RequestType.upcoming);
});

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends Notifier<List<Movie>> {
  MoviesNotifier({required this.requestType});
  int currentPage = 0;
  bool _isLoading = false;

  RequestType requestType;

  late MovieStrategy movieStrategy;

  @override
  List<Movie> build() {
    movieStrategy = MovieStrategyFactory().create(requestType, ref);
    return [];
  }

  Future<void> loadNextPage() async {
    if (_isLoading) return;

    _isLoading = true;
    currentPage++;

    final List<Movie> movies =
        await movieStrategy.fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 300));
    _isLoading = false;
  }
}

enum RequestType { nowPlaying, popular, topRated, upcoming }

class MovieStrategy {
  final MovieCallback movieCallback;

  MovieStrategy({required this.movieCallback});

  Future<List<Movie>> fetchMoreMovies({int page = 1}) async {
    return await movieCallback(page: page);
  }
}

class MovieStrategyFactory {
  MovieStrategy create(
      RequestType requestType, NotifierProviderRef<List<Movie>> ref) {
    late MovieCallback movieCallback;

    if (requestType == RequestType.nowPlaying) {
      movieCallback = ref.read(movieRepositoryProvider).getNowPlaying;
    } else if (requestType == RequestType.popular) {
      movieCallback = ref.read(movieRepositoryProvider).getPopular;
    } else if (requestType == RequestType.topRated) {
      movieCallback = ref.read(movieRepositoryProvider).getTopRated;
    } else if (requestType == RequestType.upcoming) {
      movieCallback = ref.read(movieRepositoryProvider).getUpcoming;
    } else {
      throw UnimplementedError();
    }
    return MovieStrategy(movieCallback: movieCallback);
  }
}
