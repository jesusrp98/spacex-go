import 'package:flutter/material.dart';

typedef SearchFilter<T> = List<String> Function(T t);
typedef ResultBuilder<T> = Widget Function(T t);

/// This class helps implement a search view, using [SearchDelegate].
/// It can show suggestion & unsuccessful-search widgets.
class SearchPage<T> extends SearchDelegate<T> {
  final Widget suggestion, failure;
  final ResultBuilder<T> builder;
  final SearchFilter<T> filter;
  final String searchLabel;
  final List<T> items;

  SearchPage({
    this.suggestion,
    this.failure,
    this.builder,
    this.filter,
    this.items,
    this.searchLabel,
  }) : super(searchFieldLabel: searchLabel);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      textTheme: TextTheme(
        title: TextStyle(color: Colors.white, fontSize: 20),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      AnimatedOpacity(
        opacity: query.isNotEmpty ? 1.0 : 0.0,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOutCubic,
        child: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => query = '',
        ),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const BackButtonIcon(),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) => buildSuggestions(context);

  @override
  Widget buildSuggestions(BuildContext context) {
    final String cleanQuery = query.toLowerCase().trim();

    final List<T> result = items
        .where((item) => filter(item)
            .map((value) => value = value?.toLowerCase()?.trim())
            .any((value) => value?.contains(cleanQuery) == true))
        .toList();

    return cleanQuery.isEmpty
        ? suggestion
        : result.isEmpty
            ? failure
            : ListView(children: result.map(builder).toList());
  }
}
