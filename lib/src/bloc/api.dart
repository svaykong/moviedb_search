import 'dart:convert' as json;

import '../models/base_movie_model.dart';
import '../repos/network_repo.dart';
import '../utils/constants.dart';
import '../utils/logger.dart';

typedef SearchTerm = String; // declared String keyword

class Api {
  List<Result>? _results;

  // default constructor
  Api() {
    _httpRequest = NetworkRepo.instance;
  }

  late final NetworkRepo _httpRequest;
  String url = '/search/movie';
  String param = '';

  // Search Movie with search term
  Future<List<Result>> search(SearchTerm searchTerm) async {
    'search start'.log();
    try {
      final term = searchTerm.trim().toLowerCase();
      'search term: [$term]'.log();

      // search in the cache
      // final cachedResults = _extractResultsUsingSearchTerm(term);
      // if (cachedResults != null) {
      //   return cachedResults;
      // }

      // we don't have the values cached, let's call APIs
      // start by calling moviedb api

      String params = 'api_key=$API_KEY';
      params += '&query=$term';
      params += '&include_adult=false';
      params += '&language=en-US';
      params += '&page=1';

      var response = await _httpRequest.get(url: url, params: params);
      var jsonResult = json.jsonDecode(response.body);
      var baseMovie = BaseMovieModel.fromJson(jsonResult);
      _results = baseMovie.results;

      // return _extractResultsUsingSearchTerm(term) ?? [];
      return _results ?? [];
    } on Exception catch (e) {
      'search exception: $e'.log();
      return [];
    } finally {
      'search finally'.log();
    }
  }

  List<Result>? _extractResultsUsingSearchTerm(SearchTerm term) {
    final cachedResults = _results;

    if (cachedResults != null) {
      List<Result> results = [];
      // go through results
      for (final result in cachedResults) {
        if (result.title.trimmedContains(term) || result.overview.trimmedContains(term)) {
          results.add(result);
        }
      }
      return results;
    } else {
      return null;
    }
  }
}

extension TrimmedCaseInsensitiveContain on String {
  bool trimmedContains(String other) => trim().toLowerCase().contains(other.trim().toLowerCase());
}
