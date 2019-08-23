import 'package:flutter/material.dart';

typedef List<String> SearchFilter<T>(T item);
typedef Widget ResultBuilder<T>(T item);

// TODO doc
class SearchPage<T> extends SearchDelegate<T> {
  final ResultBuilder<T> resultBuilder;
  final Widget suggestion, unsuccessful;
  final SearchFilter<T> filter;
  final List<T> items;

  SearchPage({
    this.resultBuilder,
    this.suggestion,
    this.unsuccessful,
    this.filter,
    this.items,
  });

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 20,
        ),
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
      icon: BackButtonIcon(),
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
            .map((value) => value = value.toLowerCase().trim())
            .any((value) => value.contains(cleanQuery)))
        .toList();

    return cleanQuery.isEmpty
        ? suggestion
        : result.isEmpty
            ? unsuccessful
            : ListView(children: result.map(resultBuilder).toList());
  }
}
