import 'package:flutter/material.dart';

/// CARD PAGE CLASS
/// Widget used in details pages, like Launch Page or Rocket Page.
/// Used to display information, with Row Item object.
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
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Text(
                title,
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
