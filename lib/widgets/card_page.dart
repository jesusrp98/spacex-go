import 'package:flutter/material.dart';
import 'package:row_collection/row_collection.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/app_model.dart';
import 'expand_widget.dart';

/// CARD PAGE WIDGET
/// Widget used in details pages, like 'Launch Page' or 'Rocket Page'.
class CardPage extends StatelessWidget {
  final Widget body;

  const CardPage(this.body);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          width: 1,
          color: ScopedModel.of<AppModel>(context).theme == Themes.black
              ? Theme.of(context).dividerColor
              : Colors.transparent,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: body,
      ),
    );
  }

  factory CardPage.header({
    Widget leading,
    Widget subtitle,
    String title,
    String details,
  }) {
    return CardPage(
      RowLayout(children: <Widget>[
        Row(children: <Widget>[
          leading,
          Separator.spacer(space: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Separator.spacer(space: 6),
                subtitle,
              ],
            ),
          ),
        ]),
        Separator.divider(),
        TextExpand(text: details, maxLength: 7)
      ]),
    );
  }

  factory CardPage.body({String title, Widget body}) {
    return CardPage(
      RowLayout(
        children: <Widget>[
          Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          body
        ],
      ),
    );
  }
}
