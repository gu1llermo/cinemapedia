import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
          : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
          : 'https://www.movienewz.com/img/films/poster-holder.jpg',
      releaseDate:
          moviedb.releaseDate != null ? moviedb.releaseDate! : DateTime.now(),
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount);

  static Movie movieDetailsToEntity(MovieDetails moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
          : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
      genreIds: moviedb.genres.map((e) => e.name).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
          : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount);

  static Map<String, dynamic> entityToMap(Movie movie) {
    return {
      'adult': movie.adult,
      'backdropPath': movie.backdropPath,
      'genreIds': movie.genreIds,
      'id': movie.id,
      'originalLanguage': movie.originalLanguage,
      'originalTitle': movie.originalTitle,
      'overview': movie.overview,
      'popularity': movie.popularity,
      'posterPath': movie.posterPath,
      // 'releaseDate': movie.releaseDate,
      'releaseDate': movie.releaseDate != null
          ? "${movie.releaseDate!.year.toString().padLeft(4, '0')}-${movie.releaseDate!.month.toString().padLeft(2, '0')}-${movie.releaseDate!.day.toString().padLeft(2, '0')}"
          : null,
      'title': movie.title,
      'video': movie.video,
      'voteAverage': movie.voteAverage,
      'voteCount': movie.voteCount,
    };
  }

  static Movie mapToEntity(Map<String, dynamic> json) => Movie(
        adult: json['adult'],
        backdropPath: json['backdropPath'],
        genreIds: List<String>.from(json['genreIds'].map((x) => x)),
        id: json['id'],
        originalLanguage: json['originalLanguage'],
        originalTitle: json['originalTitle'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['posterPath'],
        // releaseDate: DateTime.parse(json['releaseDate']),
        releaseDate: json['releaseDate'] != ''
            ? DateTime.parse(json['releaseDate'])
            : null,
        title: json['title'],
        video: json['video'],
        voteAverage: json['voteAverage'],
        voteCount: json['voteCount'],
      );
}
