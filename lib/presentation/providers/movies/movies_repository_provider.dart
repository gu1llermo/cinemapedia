import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';

// éste repositorio es inmutable
final movieRepositoryProvider = Provider(
  (ref) => MovieRepositoryImpl(MoviedbDatasource()),
);
