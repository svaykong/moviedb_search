import 'package:flutter/foundation.dart' show immutable;

import 'package:equatable/equatable.dart';

import '../utils/constants.dart';

@immutable
class BaseMovieModel extends Equatable {
  const BaseMovieModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;

  factory BaseMovieModel.fromJson(Map<String, dynamic> json) {
    var tmpResults = List.from(json['results']).map((result) => Result.fromJson(result)).toList();
    return BaseMovieModel(
      page: json['page'],
      results: tmpResults,
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }

  @override
  List<Object?> get props => [
        page,
        results,
        totalResults,
        totalResults,
      ];
}

class Result extends Equatable {
  const Result({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  factory Result.fromJson(Map<String, dynamic> json) {
    String? posterPath = json["poster_path"];
    if (posterPath != null) {
      posterPath = '$BASE_IMAGE_W500$posterPath';
    }
    return Result(
      adult: json["adult"],
      backdropPath: json["backdrop_path"],
      genreIds: List.from(json["genre_ids"]).map((element) => int.parse(element.toString())).toList(),
      id: json["id"],
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      popularity: json["popularity"],
      posterPath: posterPath,
      releaseDate: json["release_date"],
      title: json["title"],
      video: json["video"],
      voteAverage: json["vote_average"],
      voteCount: json["vote_count"],
    );
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originalLanguage,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount,
      ];
}
