import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:row_collection/row_collection.dart';

import 'index.dart';

/// Widget used in details pages, like 'Launch Page' or 'Rocket Page'.
class CardPage extends StatelessWidget {
  final Widget body;

  const CardPage(this.body);

  factory CardPage.header({
    @required BuildContext context,
    Widget leading,
    Widget subtitle,
    @required String title,
    @required String details,
  }) {
    return CardPage(
      RowLayout(children: <Widget>[
        Row(children: <Widget>[
          if (leading != null) leading,
          Separator.spacer(space: 12),
          Expanded(
            child: RowLayout(
              crossAxisAlignment: CrossAxisAlignment.start,
              space: 8,
              children: <Widget>[
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme)
                      .headline6
                      .copyWith(fontSize: 18),
                ),
                if (subtitle != null) subtitle,
              ],
            ),
          ),
        ]),
        Separator.divider(),
        TextExpand(details)
      ]),
    );
  }

  factory CardPage.body({
    @required BuildContext context,
    String title,
    @required Widget body,
  }) {
    return CardPage(
      RowLayout(
        children: <Widget>[
          if (title != null)
            Text(
              title.toUpperCase(),
              textAlign: TextAlign.center,
              style: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme)
                  .headline6
                  .copyWith(fontSize: 18),
            ),
          body
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).dividerColor.withOpacity(
                Theme.of(context).brightness == Brightness.dark ? 0.4 : 0.1,
              ),
          width: 2,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: body,
      ),
    );
  }
}
