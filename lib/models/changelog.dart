import 'package:flutter/material.dart';

import '../util/url.dart';
import 'query_model.dart';

class ChangelogModel extends QueryModel {
  @override
  Future loadData([BuildContext context]) async {
    // Clear old data
    clearItems();

    // Fetch & add items
    String changelog = await fetchData(Url.changelog);

    items.add(changelog);

    // Finished loading data
    setLoading(false);
  }

  String get changelog => getItem(0);
}
