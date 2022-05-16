import 'dart:convert';

import 'Movie.dart';

class MovieResponse {
  int? page;
  final int? totalResults;
  final int? totalPages;
  final List<Movie>? movies;

  MovieResponse({
    this.page,
    this.totalResults,
    this.totalPages,
    this.movies,
  });

  factory MovieResponse.fromJson(String str) =>
      MovieResponse.fromMap(json.decode(str));

  factory MovieResponse.fromMap(Map<String, dynamic> json) =>
      MovieResponse(
        page: json["page"],
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
        movies: List<Movie>.from(
            json["results"].map((x) => Movie.fromMap(x))),
      );
}