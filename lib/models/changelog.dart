// import 'package:flutter/material.dart';

// import '../classes/query_model.dart';
// import '../util/url.dart';

// /// Loads the app changelog, using the [Url.changelog] url.
// class ChangelogModel extends QueryModel {
//   @override
//   Future loadData([BuildContext context]) async {
//     if (await canLoadData()) {
//       // Fetch & add items
//       items.add(await fetchData(Url.changelog));

//       finishLoading();
//     }
//   }

//   String get changelog => getItem(0) ?? '';
// }
