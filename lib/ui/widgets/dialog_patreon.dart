import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:row_collection/row_collection.dart';

import '../../util/url.dart';
import 'index.dart';

/// List of past & current Patreon supporters.
/// Thanks to you all! :)
const List<String> _patreons = [
  'Ahmed Al Hamada',
  'Pierangelo Pancera',
  'John Stockbridge',
  'Michael Christenson II',
  'Tim van der Linde',
];

/// Dialog that appears every once in a while, with
/// the Patreon information from this app's lead developer.
class PatreonDialog extends StatelessWidget {
  final Widget body;

  const PatreonDialog({@required this.body});

  factory PatreonDialog.home(BuildContext context) {
    return PatreonDialog(
      body: Row(
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
    );
  }

  factory PatreonDialog.about(BuildContext context) {
    return PatreonDialog(
      body: RowLayout(children: <Widget>[
        for (String patreon in _patreons)
          Text(
            patreon,
            style: Theme.of(context).textTheme.title.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).textTheme.caption.color,
                ),
          ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RoundDialog(
      title: FlutterI18n.translate(context, 'about.patreon.title'),
      children: <Widget>[
        RowLayout(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: <Widget>[
            Text(
              FlutterI18n.translate(context, 'about.patreon.body_dialog'),
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.subhead.copyWith(
                    color: Theme.of(context).textTheme.caption.color,
                  ),
            ),
            body,
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      FlutterI18n.translate(context, 'about.patreon.dismiss'),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  OutlineButton(
                    highlightedBorderColor: Theme.of(context).accentColor,
                    borderSide: BorderSide(
                      color: Theme.of(context).textTheme.title.color,
                    ),
                    onPressed: () async {
                      Navigator.pop(context, true);
                      await FlutterWebBrowser.openWebPage(
                        url: Url.authorPatreon,
                        androidToolbarColor: Theme.of(context).primaryColor,
                      );
                    },
                    child: const Text('PATREON'),
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
