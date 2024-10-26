// To parse this JSON data, do
//
//     final searchMovieResponse = searchMovieResponseFromJson(jsonString);

import 'dart:convert';

import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

SearchMovieResponse searchMovieResponseFromJson(String str) =>
    SearchMovieResponse.fromJson(json.decode(str));

String searchMovieResponseToJson(SearchMovieResponse data) =>
    json.encode(data.toJson());

class SearchMovieResponse {
  final int page;
  final List<MovieMovieDB> results;
  final int totalPages;
  final int totalResults;

  SearchMovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchMovieResponse.fromJson(Map<String, dynamic> json) =>
      SearchMovieResponse(
        page: json["page"],
        results: List<MovieMovieDB>.from(
            json["results"].map((x) => MovieMovieDB.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
