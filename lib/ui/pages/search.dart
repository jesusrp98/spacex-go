import 'package:flutter/material.dart';

typedef List<String> SearchFilter<T>(T t);
typedef Widget ResultBuilder<T>(T t);

/// This class helps implement a search view, using [SearchDelegate].
/// It can show suggestion & unsuccessful-search widgets.
class SearchPage<T> extends SearchDelegate<T> {
  // TODO implement new parameters once they land on stable
  final Widget unsuccessful, suggestion;
  final ResultBuilder<T> resultBuilder;
  final TextTheme activeText, hintText;
  final SearchFilter<T> filter;
  final List<T> items;

  SearchPage({
    this.unsuccessful,
    this.suggestion,
    this.resultBuilder,
    this.activeText,
    this.hintText,
    this.filter,
    this.items,
  });

  // TODO delete custom themes
  /// Applies a custom theme to the search page's app bar.
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      textTheme: TextTheme(
        title: activeText ?? TextStyle(color: Colors.white, fontSize: 20),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: hintText ?? TextStyle(color: Colors.grey, fontSize: 20),
      ),
    );
  }

  /// Builds an icon widget, which clears the query text.
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

  /// Builds a [BackButtonIcon] widget, which closes the search page.
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: BackButtonIcon(),
      onPressed: () => close(context, null),
    );
  }

  /// Builds the same widget as the [buildSuggestions] method.
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
