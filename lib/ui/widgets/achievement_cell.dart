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
                  height: 39,
                  width: 39,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor.withOpacity(0.65),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).accentColor,
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      index.toString(),
                      style: GoogleFonts.rubikTextTheme(
                        Theme.of(context).textTheme,
                      ).headline6.copyWith(
                            fontSize: 18,
                            color: Theme.of(context)
                                .accentTextTheme
                                .subtitle1
                                .color,
                          ),
                    ),
                  ),
                ),
                Separator.spacer(),
                Expanded(
                  child: RowLayout(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    space: 3,
                    children: <Widget>[
                      Text(
                        title,
                        style: GoogleFonts.rubikTextTheme(
                          Theme.of(context).textTheme,
                        ).subtitle1.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        subtitle,
                        style: GoogleFonts.rubikTextTheme(
                          Theme.of(context).textTheme,
                        ).bodyText2,
                      ),
                    ],
                  ),
                )
              ]),
            ),
            Icon(Icons.chevron_right),
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
