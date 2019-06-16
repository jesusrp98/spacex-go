import 'package:flutter/material.dart';

import '../util/url.dart';
import 'query_model.dart';

class ChangelogModel extends QueryModel {
  @override
  Future loadData([BuildContext context]) async {
    if (await connectionFailure())
      receivedError();
    else {
      // Fetch & add items
      items.add(await fetchData(Url.changelog));

      finishLoading();
    }
  }

  String get changelog => getItem(0);
}
