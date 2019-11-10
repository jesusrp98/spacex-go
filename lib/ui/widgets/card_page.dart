import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';

import '../../data/models/index.dart';
import 'index.dart';

/// Widget used in details pages, like 'Launch Page' or 'Rocket Page'.
class CardPage extends StatelessWidget {
  final Widget body;

  const CardPage(this.body);

  factory CardPage.header({
    Widget leading,
    Widget subtitle,
    @required String title,
    @required String details,
  }) {
    return CardPage(
      RowLayout(children: <Widget>[
        Row(children: <Widget>[
          if (leading != null) leading,
          Separator.spacer(space: 12),
          Expanded(
            child: RowLayout(
              crossAxisAlignment: CrossAxisAlignment.start,
              space: 6,
              children: <Widget>[
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'ProductSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle != null) subtitle,
              ],
            ),
          ),
        ]),
        Separator.divider(),
        TextExpand(details)
      ]),
    );
  }

  factory CardPage.body({
    String title,
    @required Widget body,
  }) {
    return CardPage(
      RowLayout(
        children: <Widget>[
          if (title != null)
            Text(
              title.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'ProductSans',
                fontWeight: FontWeight.bold,
              ),
            ),
          body
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Provider.of<AppModel>(context).theme == Themes.black
              ? Theme.of(context).dividerColor
              : Colors.transparent,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: body,
      ),
    );
  }
}
