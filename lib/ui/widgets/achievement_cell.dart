import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:row_collection/row_collection.dart';

import 'index.dart';

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
      contentPadding: const EdgeInsets.symmetric(
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
              fontFamily: 'ProductSans',
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
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'ProductSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'ProductSans',
                ),
              ),
            ],
          ),
        )
      ]),
      subtitle: Column(children: <Widget>[
        Separator.smallSpacer(),
        TextExpand.small(body),
      ]),
      onTap: () => FlutterWebBrowser.openWebPage(
        url: url,
        androidToolbarColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
