import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:google_fonts/google_fonts.dart';
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
            style: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme)
                .subtitle1
                .copyWith(
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
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: <Widget>[
            Text(
              FlutterI18n.translate(context, 'about.patreon.body_dialog'),
              textAlign: TextAlign.justify,
              style: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme)
                  .subtitle1
                  .copyWith(
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
                      style: GoogleFonts.rubikTextTheme(
                        Theme.of(context).textTheme,
                      ).bodyText2.copyWith(
                            color: Theme.of(context).textTheme.caption.color,
                          ),
                    ),
                  ),
                  OutlineButton(
                    highlightedBorderColor: Theme.of(context).accentColor,
                    borderSide: BorderSide(
                      color: Theme.of(context).textTheme.headline6.color,
                    ),
                    onPressed: () {
                      Navigator.pop(context, true);
                      FlutterWebBrowser.openWebPage(
                        url: Url.authorPatreon,
                        androidToolbarColor: Theme.of(context).primaryColor,
                      );
                    },
                    child: Text(
                      'PATREON',
                      style: GoogleFonts.rubikTextTheme(
                        Theme.of(context).textTheme,
                      ).bodyText2,
                    ),
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
