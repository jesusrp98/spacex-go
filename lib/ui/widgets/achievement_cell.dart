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
                    color: Theme.of(context).accentColor.withOpacity(0.65),
                    border: Border.all(
                      color: Theme.of(context).accentColor,
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      index.toString(),
                      style: GoogleFonts.varelaRound(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).accentTextTheme.subtitle1.color,
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
                        style: GoogleFonts.varelaRound(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: GoogleFonts.varelaRound(
                          fontSize: 15,
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
