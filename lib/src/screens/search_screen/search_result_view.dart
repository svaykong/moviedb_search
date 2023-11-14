import 'package:flutter/material.dart';

import '../../utils/logger.dart';
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

class BuildResultListView extends StatefulWidget {
  const BuildResultListView({
    super.key,
    required this.scrollController,
    required this.results,
  });

  final ScrollController scrollController;
  final List<Result> results;

  @override
  State<BuildResultListView> createState() => _BuildResultListViewState();
}

class _BuildResultListViewState extends State<BuildResultListView> {
  int _totals = 0;
  int _currentPageIndex = 1;
  List<Result> _results = [];

  @override
  void initState() {
    super.initState();
    _totals = (widget.results.length / 10).ceil();
    'totals: $_totals'.log();

    if (_totals > 1) {
      _results = widget.results.take(10).toList();
    } else {
      _results = widget.results;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                controller: widget.scrollController,
                itemCount: _currentPageIndex == 1
                    ? _totals > 1
                        ? 10
                        : _results.length
                    : _results.length,
                itemBuilder: (context, index) {
                  final item = _results[index];
                  return SearchResultCard(item: item);
                }),
          ),
          _displayNextPage,
        ],
      ),
    );
  }

  Widget get _displayNextPage {
    if (_totals == 1) {
      return const SizedBox.shrink();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 1; i <= _totals; i++)
          TextButton(
            onPressed: () {
              setState(() {
                _currentPageIndex = i;

                if (_currentPageIndex == 1) {
                  _results = widget.results.take(10).toList();
                } else {
                  _results = [];
                  for (var j = 10; j < widget.results.length; j++) {
                    _results = [..._results, widget.results[j]];
                  }
                }
              });
            },
            child: _currentPageIndex == i
                ? Chip(
                    label: Text(i.toString()),
                  )
                : Text(i.toString()),
          ),
      ],
    );
  }
}
