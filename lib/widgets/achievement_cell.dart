import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:row_collection/row_collection.dart';

import 'expand_widget.dart';

/// ACHIEVEMENT CELL WIDGET
/// Widget used in SpaceX's achievement list, under the 'Home Screen'.
class AchievementCell extends StatelessWidget {
  final String title, subtitle, body, url;
  final int index;

  const AchievementCell({
    @required this.title,
    @required this.subtitle,
    @required this.body,
    @required this.url,
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 16,
      ),
      title: Row(children: <Widget>[
        CircleAvatar(
          radius: 20,
          backgroundColor: Theme.of(context).accentColor,
          child: Text(
            '#$index',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
        Separator.spacer(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text(subtitle, style: Theme.of(context).textTheme.subhead),
            ],
          ),
        )
      ]),
      subtitle: Column(children: <Widget>[
        Separator.smallSpacer(),
        TextExpand.small(body),
      ]),
      onTap: () async => await FlutterWebBrowser.openWebPage(
            url: url,
            androidToolbarColor: Theme.of(context).primaryColor,
          ),
    );
  }
}
