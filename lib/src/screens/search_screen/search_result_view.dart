import 'package:flutter/material.dart';

import '../../models/base_movie_model.dart';
import '../../bloc/search_result.dart';
import 'search_result_card.dart';

class SearchResultView extends StatelessWidget {
  const SearchResultView({
    super.key,
    required this.searchResult,
    required this.scrollController,
  });

  final Stream<SearchResult?> searchResult;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SearchResult?>(
      stream: searchResult,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final result = snapshot.data;
          if (result is SearchResultHasError) {
            return const Center(
              child: Text('Got an error'),
            );
          } else if (result is SearchResultLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (result is SearchResultNoResult) {
            return const Center(
              child: Text('No results found.'),
            );
          } else if (result is SearchResultWithResults) {
            final results = result.results;

            return BuildResultListView(
              scrollController: scrollController,
              results: results,
            );
          }

          return const Text('Unknown state!');
        } else {
          // return const Text('Waiting');
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class BuildResultListView extends StatelessWidget {
  const BuildResultListView({
    super.key,
    required this.scrollController,
    required this.results,
  });

  final ScrollController scrollController;
  final List<Result> results;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          controller: scrollController,
          itemCount: results.length,
          itemBuilder: (context, index) {
            final item = results[index];
            return SearchResultCard(item: item);
          }),
    );
  }
}
