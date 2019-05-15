import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:material_search/material_search.dart';

import '../../models/launch.dart';
import '../pages/launch.dart';

/// SEARCH LAUNCHES METHOD
/// Auxiliary method which helps filter launches by its name
searchLaunches(BuildContext context, List list) {
  return MaterialPageRoute<Launch>(
    builder: (context) => Material(
          child: MaterialSearch<Launch>(
            barBackgroundColor: Theme.of(context).primaryColor,
            iconColor: Colors.white,
            placeholder: FlutterI18n.translate(
              context,
              'spacex.other.tooltip.search',
            ),
            limit: list.length,
            results: list
                .map((item) => MaterialSearchResult<Launch>(
                      icon: Icons.search,
                      value: item,
                      text: item.name,
                    ))
                .toList(),
            filter: (dynamic value, String criteria) => (value as Launch)
                .name
                .toLowerCase()
                .trim()
                .contains(RegExp(r'' + criteria.toLowerCase().trim() + '')),
            onSelect: (dynamic launch) => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LaunchPage(launch)),
                ),
          ),
        ),
  );
}
