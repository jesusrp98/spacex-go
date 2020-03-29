import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return InkWell(
      onTap: () => FlutterWebBrowser.openWebPage(
        url: url,
        androidToolbarColor: Theme.of(context).primaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            Expanded(
              child: Row(children: <Widget>[
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).accentColor,
                  ),
                  child: Center(
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
                ),
                Separator.spacer(),
                Expanded(
                  child: RowLayout(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    space: 2,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'ProductSans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'ProductSans',
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            ),
            Icon(
              Icons.chevron_right,
              color: Theme.of(context).textTheme.caption.color,
            ),
          ]),
          Column(children: <Widget>[
            Separator.smallSpacer(),
            TextExpand.small(body),
          ]),
        ]),
      ),
    );
  }
}
