import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import 'separator.dart';

/// ACHIEVEMENT CELL WIDGET
/// Widget used in SpaceX's achievement list, under the 'Home Screen'.
class AchievementCell extends StatelessWidget {
  final String title, subtitle, body, url;
  final int index;

  AchievementCell({
    this.title,
    this.subtitle,
    this.body,
    this.url,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      title: Row(children: <Widget>[
        CircleAvatar(
          radius: 25.0,
          backgroundColor: Theme.of(context).textTheme.subhead.color,
          child: Text(
            '#$index',
            style: Theme.of(context).textTheme.title.copyWith(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white,
                ),
          ),
        ),
        Separator.spacer(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Separator.spacer(height: 4.0),
              Text(subtitle, style: Theme.of(context).textTheme.subhead),
            ],
          ),
        )
      ]),
      subtitle: Column(children: <Widget>[
        Separator.spacer(height: 8.0),
        Text(
          body,
          textAlign: TextAlign.justify,
          style: Theme.of(context)
              .textTheme
              .subhead
              .copyWith(color: Theme.of(context).textTheme.caption.color),
        ),
      ]),
      onTap: () async => await FlutterWebBrowser.openWebPage(
            url: url,
            androidToolbarColor: Theme.of(context).primaryColor,
          ),
    );
  }
}
