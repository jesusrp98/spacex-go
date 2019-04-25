import 'package:flutter/material.dart';

import '../util/colors.dart';
import 'expand_widget.dart';
import 'separator.dart';

/// CARD PAGE WIDGET
/// Widget used in details pages, like 'Launch Page' or 'Rocket Page'.
class CardPage extends StatelessWidget {
  final Widget body;

  CardPage(this.body);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          width: 0.0,
          color: Theme.of(context).canvasColor == blackBackgroundColor
              ? blackCardBorderColor
              : Colors.transparent,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
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
      Column(children: <Widget>[
        Row(children: <Widget>[
          leading,
          Separator.spacer(width: 12),
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
                Separator.spacer(height: 8),
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
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Separator.spacer(),
          body
        ],
      ),
    );
  }
}
