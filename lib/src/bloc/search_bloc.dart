import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';

import 'api.dart';
import 'search_result.dart';

@immutable
class SearchBloc {
  final Sink<String> search; // write-stream (search event)

  // clean up (search event)
  void dispose() {
    search.close();
  }

  // read-stream (search result event)
  final Stream<SearchResult?> results;

  // create factory constructor
  factory SearchBloc({required Api api}) {
    // BehaviorSubject is read-stream & write-stream
    final textChanges = BehaviorSubject<String>();

    final Stream<SearchResult?> results = textChanges
        .distinct() // produce only unique value and ignore duplicate value
        .debounceTime(const Duration(milliseconds: 300)) // waiting specific time completed then produce a value
        .switchMap<SearchResult?>((String searchTerm) {
      if (searchTerm.isEmpty) {
        // search term is empty
        // will transform value to the stream of null
        return Stream<SearchResult?>.value(null);
      } else {
        return Rx.fromCallable(() => api.search(searchTerm))
            .delay(const Duration(milliseconds: 300))
            .map((results) => results.isEmpty ? const SearchResultNoResult() : SearchResultWithResults(results: results))
            .startWith(const SearchResultLoading())
            .onErrorReturnWith((error, stackTrace) => SearchResultHasError(error: error));
      }
    });

    return SearchBloc._(search: textChanges.sink, results: results);
  }

  // create a private constructor
  const SearchBloc._({required this.search, required this.results});
}
