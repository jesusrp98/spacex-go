import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:row_collection/row_collection.dart';

import '../util/url.dart';
import 'dialog_round.dart';

/// PATREON DIALOG
/// Dialog that appears every once in a while, with
/// the Patreon information from this app's lead developer.
class PatreonDialog extends StatelessWidget {
  static const List<String> _patreons = [
    'Pierangelo Pancera',
    'Michael Christenson II',
    'Malcolm Lockyer'
  ];

  @override
  Widget build(BuildContext context) {
    return RoundDialog(
      title: FlutterI18n.translate(context, 'about.patreon.title'),
      children: <Widget>[
        RowLayout(
          padding: EdgeInsets.symmetric(horizontal: 24),
          children: <Widget>[
            Text(
              FlutterI18n.translate(context, 'about.patreon.body_dialog'),
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.subhead.copyWith(
                    color: Theme.of(context).textTheme.caption.color,
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  Icons.cake,
                  size: 50,
                  color: Theme.of(context).textTheme.caption.color,
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 30,
                  color: Theme.of(context).textTheme.caption.color,
                ),
                Icon(
                  Icons.sentiment_satisfied,
                  size: 50,
                  color: Theme.of(context).textTheme.caption.color,
                ),
              ],
            ),
            Separator.divider(),
            for (String patreon in _patreons)
              Text(
                patreon,
                style: Theme.of(context).textTheme.subhead.copyWith(
                      color: Theme.of(context).textTheme.caption.color,
                    ),
              ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      FlutterI18n.translate(context, 'about.patreon.dismiss'),
                      style: Theme.of(context).textTheme.caption,
                    ),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  OutlineButton(
                    highlightedBorderColor: Theme.of(context).accentColor,
                    borderSide: BorderSide(
                      color: Theme.of(context).textTheme.title.color,
                    ),
                    child: Text('PATREON'),
                    onPressed: () async {
                      Navigator.pop(context, true);
                      await FlutterWebBrowser.openWebPage(
                        url: Url.authorPatreon,
                        androidToolbarColor: Theme.of(context).primaryColor,
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
