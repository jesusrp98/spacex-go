import 'package:flutter/material.dart';

/// CARD PAGE WIDGET
/// Widget used in details pages, like 'Launch Page' or 'Rocket Page'.
class CardPage extends StatelessWidget {
  final String title;
  final Widget body;

  CardPage({
    @required this.title,
    @required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                title.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            body
          ],
        ),
      ),
    );
  }
}
