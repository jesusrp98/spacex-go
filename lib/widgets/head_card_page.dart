import 'package:flutter/material.dart';

import 'separator.dart';

/// HEAD CARD PAGE WIDGET
/// Widget used as page head in details pages, like 'Launch Page' or 'Rocket Page'.
class HeadCardPage extends StatelessWidget {
  final Widget image;
  final String title, details;
  final Widget subtitle1, subtitle2;

  HeadCardPage({
    this.image,
    this.title,
    this.details,
    this.subtitle1,
    this.subtitle2,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            image,
            Separator.spacer(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Separator.spacer(height: 12.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      subtitle1,
                      Separator.spacer(height: 8.0),
                      subtitle2,
                    ],
                  ),
                ],
              ),
            ),
          ]),
          Separator.divider(),
          Text(
            details,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 15.0,
              color: Theme.of(context).textTheme.caption.color,
            ),
          )
        ]),
      ),
    );
  }
}
