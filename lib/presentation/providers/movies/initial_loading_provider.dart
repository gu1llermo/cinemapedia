import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'movies_providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final topRatedMovies = ref.watch(topRatedMoviesProvider).isEmpty;
  final upcominggMovies = ref.watch(upcomingMoviesProvider).isEmpty;
  final popularMovies = ref.watch(popularMoviesProvider).isEmpty;

// retorna falso cuando todo está listo, que terminó de cargar
  return nowPlayingMovies || topRatedMovies || upcominggMovies || popularMovies;
});
