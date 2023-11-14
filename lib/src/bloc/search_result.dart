import 'package:flutter/foundation.dart' show immutable;

import '../models/base_movie_model.dart';

// creating SearchResult interface
@immutable
abstract class SearchResult {}

// SearchResult Loading
@immutable
class SearchResultLoading implements SearchResult {
  const SearchResultLoading();
}

// SearchResult NoResult
@immutable
class SearchResultNoResult implements SearchResult {
  const SearchResultNoResult();
}

// SearchResult HasError
@immutable
class SearchResultHasError implements SearchResult {
  const SearchResultHasError({required this.error});

  final Object error;
}

// SearchResult WithResults
class SearchResultWithResults implements SearchResult {
  const SearchResultWithResults({required this.results});

  final List<Result> results;
}
