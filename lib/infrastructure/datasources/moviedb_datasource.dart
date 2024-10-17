import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:dio/dio.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMoviedbKey,
      'language': 'es-MX'
    },
  ));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDbResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDbResponse.results
        .where((movieMovieDb) => movieMovieDb.posterPath != 'no-poster')
        .map((movieMovieDb) => MovieMapper.movieDBToEntity(movieMovieDb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {'page': page},
    );

    return _jsonToMovies(response.data);
    // final movieDbResponse = MovieDbResponse.fromJson(response.data);

    // final List<Movie> movies = movieDbResponse.results
    //     .where((movieMovieDb) => movieMovieDb.posterPath != 'no-poster')
    //     .map((movieMovieDb) => MovieMapper.movieDBToEntity(movieMovieDb))
    //     .toList();

    // return movies;
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {'page': page},
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {'page': page},
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {'page': page},
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) {
      throw Exception('Movie with id $id not found!');
    }
    final movieDetails = MovieDetails.fromJson(response.data);

    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);
    return movie;
  }

  @override
  Future<List<Movie>> searchMovie(String query) async {
    if (query.isEmpty) return []; // si está vacío regresa un string vacío
    final response =
        await dio.get('/search/movie', queryParameters: {'query': query});

    return _jsonToMovies(response.data);

    // final searchMovieResponse = SearchMovieResponse.fromJson(response.data);

    // final List<Movie> movies = searchMovieResponse.results
    //     .map((movieMovieDb) => MovieMapper.movieDBToEntity(movieMovieDb))
    //     .toList();

    // return movies;
  }
}
