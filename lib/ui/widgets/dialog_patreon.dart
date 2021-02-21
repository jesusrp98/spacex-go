import 'package:cherry_components/cherry_components.dart';
import 'package:flutter/material.dart';
import 'package:row_collection/row_collection.dart';

import '../../util/index.dart';

/// List of past & current Patreon supporters.
/// Thanks to you all! :)
const List<String> _patreons = [
  'John Stockbridge',
  'Ahmed Al Hamada',
  'Michael Christenson II',
  'Malcolm',
  'Pierangelo Pancera',
  'Sam M',
  'Tim van der Linde',
  'David Morrow'
];

/// Dialog that appears every once in a while, with
/// the Patreon information from this app's lead developer.
Future<T> showPatreonDialog<T>(BuildContext context) {
  return showRoundDialog(
    context: context,
    title: context.translate('about.patreon.title'),
    children: [
      RowLayout(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: <Widget>[
          Text(
            context.translate('about.patreon.body_dialog'),
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Theme.of(context).textTheme.caption.color,
                ),
          ),
          for (String patreon in _patreons)
            Text(
              patreon,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Theme.of(context).textTheme.caption.color,
                  ),
            ),
          if (Theme.of(context).platform != TargetPlatform.iOS)
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      context.translate('about.patreon.dismiss'),
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
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
                      context.openUrl(Url.authorPatreon);
                    },
                    child: Text(
                      'PATREON',
                      style: Theme.of(context).textTheme.bodyText2,
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
