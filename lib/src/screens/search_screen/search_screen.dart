import 'package:flutter/material.dart';

import '../../bloc/api.dart';
import '../../bloc/search_bloc.dart';
import '../../screens/search_screen/search_result_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showBtn = false;
  late final TextEditingController _searchTextCtr;
  late final SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      //scroll listener
      double showOffSet = 10.0; //Back to top button will show on scroll offset 10.0

      if (_scrollController.offset > showOffSet) {
        _showBtn = true;
        setState(() {
          //update state
        });
      } else {
        _showBtn = false;
        setState(() {
          //update state
        });
      }
    });
    _searchTextCtr = TextEditingController();
    _searchBloc = SearchBloc(api: Api());
  }

  @override
  void dispose() {
    // clean up the resource when no longer need
    _scrollController.dispose();
    _searchTextCtr.dispose();
    _searchBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchTextCtr,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: "Search...",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  suffixIcon: _searchTextCtr.text.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            if (_searchTextCtr.text.isNotEmpty) {
                              setState(() {
                                _searchTextCtr.clear();
                              });
                            }
                          },
                          icon: const Icon(Icons.clear),
                        ),
                ),
                onChanged: (text) {
                  setState(() {
                    _searchTextCtr.text = text;
                  });
                  _searchBloc.search.add(text);
                },
                onTapOutside: (event) {
                  // un-focus click outside
                  FocusManager.instance.primaryFocus!.unfocus();
                },
              ),
            ),
            SearchResultView(
              searchResult: _searchBloc.results,
              scrollController: _scrollController,
            ),
          ],
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        duration: const Duration(milliseconds: 1000), //show/hide animation
        opacity: _showBtn ? 1.0 : 0.0, //set opacity to 1 on visible, or hide
        child: FloatingActionButton(
          onPressed: () {
            _scrollController.animateTo(
                //go to top of scroll
                0, //scroll offset to go
                duration: const Duration(milliseconds: 500), //duration of scroll
                curve: Curves.fastOutSlowIn //scroll type
                );
          },
          backgroundColor: Colors.grey,
          child: const Icon(
            Icons.arrow_upward,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }
}
