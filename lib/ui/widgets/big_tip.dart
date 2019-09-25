import 'package:flutter/material.dart';
import 'package:row_collection/row_collection.dart';

/// This widget helps to show the user a [message], with a huge [icon] above it.
class BigTip extends StatelessWidget {
  final IconData icon;
  final String message;

  const BigTip({this.icon, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: RowLayout(
          space: 32,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              size: 100,
              color: Theme.of(context).textTheme.caption.color,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
