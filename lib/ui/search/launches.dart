import 'package:flutter/material.dart';
import 'package:row_collection/row_collection.dart';

import '../../data/models/index.dart';
import '../pages/index.dart';
import '../widgets/index.dart';

class LaunchSearch extends SearchDelegate<Launch> {
  final List items;

  LaunchSearch(this.items);

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
        duration: Duration(milliseconds: 250),
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
    final String cleanedQuery = query.toLowerCase().trim();
    final List result = items
        .where((item) =>
            item.rocket.name.toLowerCase().contains(cleanedQuery) ||
            item.name.toLowerCase().contains(cleanedQuery) ||
            item.getNumber.contains(cleanedQuery) ||
            item.year.contains(cleanedQuery))
        .toList();

    return cleanedQuery.isEmpty
        ? Column(
            children: <Widget>[Text('WIP')],
          )
        : result.isEmpty
            ? Column(
                children: <Widget>[Text('Empty')],
              )
            : ListView(
                children: result
                    .map((item) => Column(
                          children: <Widget>[
                            ListCell(
                              title: item.name,
                              trailing: MissionNumber(item.getNumber),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LaunchPage(item)),
                              ),
                            ),
                            Separator.divider(indent: 16)
                          ],
                        ))
                    .toList(),
              );
  }
}
