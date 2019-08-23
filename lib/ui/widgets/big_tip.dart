import 'package:flutter/material.dart';
import 'package:row_collection/row_collection.dart';

class BigTip extends StatelessWidget {
  final IconData icon;
  final String message;

  const BigTip({this.icon, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: RowLayout(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 100,
              color: Theme.of(context).textTheme.caption.color,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).textTheme.caption.color,
                fontFamily: 'ProductSans',
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
