import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDb moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: moviedb.backdropPath != ''
          ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
          : 'https://img.pixers.pics/pho_wat(s3:700/FO/53/10/54/42/700_FO53105442_a63fa62585a7a7ac045358d268f0a2e7.jpg,700,700,cms:2018/10/5bd1b6b8d04b8_220x50-watermark.png,over,480,650,jpg)/posters-signo-de-la-carretera-amarilla-con-palabras-404-not-found.jpg.jpg',
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: moviedb.posterPath != ''
          ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
          : 'https://www.movienewsletters.net/photos/000000H1.jpg',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount);

  static Movie movieDetailsToEntity(MovieDetails movieDetail) => Movie(
      adult: movieDetail.adult,
      backdropPath: movieDetail.backdropPath != ''
          ? 'https://image.tmdb.org/t/p/w500${movieDetail.backdropPath}'
          : 'https://img.pixers.pics/pho_wat(s3:700/FO/53/10/54/42/700_FO53105442_a63fa62585a7a7ac045358d268f0a2e7.jpg,700,700,cms:2018/10/5bd1b6b8d04b8_220x50-watermark.png,over,480,650,jpg)/posters-signo-de-la-carretera-amarilla-con-palabras-404-not-found.jpg.jpg',
      genreIds: movieDetail.genres.map((e) => e.name).toList(),
      id: movieDetail.id,
      originalLanguage: movieDetail.originalLanguage,
      originalTitle: movieDetail.originalTitle,
      overview: movieDetail.overview,
      popularity: movieDetail.popularity,
      posterPath: movieDetail.posterPath != ''
          ? 'https://image.tmdb.org/t/p/w500${movieDetail.posterPath}'
          : 'https://img.pixers.pics/pho_wat(s3:700/FO/53/10/54/42/700_FO53105442_a63fa62585a7a7ac045358d268f0a2e7.jpg,700,700,cms:2018/10/5bd1b6b8d04b8_220x50-watermark.png,over,480,650,jpg)/posters-signo-de-la-carretera-amarilla-con-palabras-404-not-found.jpg.jpg',
      releaseDate: movieDetail.releaseDate,
      title: movieDetail.title,
      video: movieDetail.video,
      voteAverage: movieDetail.voteAverage,
      voteCount: movieDetail.voteCount);

  static Map<String, dynamic> entityToMap(Movie movie) {
    return {
      'sembastId': movie.sembastId,
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
        sembastId: json['sembastId'],
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
