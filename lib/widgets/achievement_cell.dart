import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../util/colors.dart';
import 'separator.dart';

/// ACHIEVEMENT CELL WIDGET
/// Widget used in SpaceX's achievement list, under the 'Home Screen'.
class AchievementCell extends StatelessWidget {
  final String title, subtitle, date, url;
  final int index;

  AchievementCell({
    this.title,
    this.subtitle,
    this.date,
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
          backgroundColor: Colors.white,
          child: Text(
            '#$index',
            style:
                Theme.of(context).textTheme.title.copyWith(color: Colors.black),
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
                  color: primaryText,
                ),
              ),
              Separator.spacer(height: 4.0),
              Text(
                date,
                style: Theme.of(context).textTheme.subhead.copyWith(
                      color: primaryText,
                    ),
              ),
            ],
          ),
        )
      ]),
      subtitle: Column(children: <Widget>[
        Separator.spacer(height: 8.0),
        Text(
          subtitle,
          textAlign: TextAlign.justify,
          style: Theme.of(context)
              .textTheme
              .subhead
              .copyWith(color: secondaryText),
        ),
      ]),
      onTap: () async => await FlutterWebBrowser.openWebPage(
            url: url,
            androidToolbarColor: primaryColor,
          ),
    );
  }
}
