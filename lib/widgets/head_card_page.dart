import 'package:flutter/material.dart';

import '../colors.dart';

/// HEAD CARD PAGE CLASS
/// Widget used as page head in details pages, like Launch Page or Rocket Page.
class HeadCardPage extends StatelessWidget {
  final Widget image;
  final String title, details;
  final Widget subtitle;

  HeadCardPage({
    this.image,
    this.title,
    this.details,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              image,
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: Theme
                          .of(context)
                          .textTheme
                          .title
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12.0),
                    subtitle
                  ],
                ),
              ),
            ]),
            const Divider(height: 24.0),
            Text(
              details,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 15.0, color: secondaryText),
            )
          ],
        ),
      ),
    );
  }
}
