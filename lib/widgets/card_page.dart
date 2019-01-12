import 'package:flutter/material.dart';

/// CARD PAGE WIDGET
/// Widget used in details pages, like 'Launch Page' or 'Rocket Page'.
class CardPage extends StatelessWidget {
  final String title;
  final Widget body;

  CardPage({this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Text(
                title.toUpperCase(),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            body
          ],
        ),
      ),
    );
  }
}
