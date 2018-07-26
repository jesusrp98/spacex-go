import 'package:flutter/material.dart';

class HeadCardPage extends StatelessWidget {
  final Widget head;
  final String details;

  HeadCardPage({this.head, this.details});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              head,
              Divider(
                height: 24.0,
              ),
              Text(
                details,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.body1,
              ),
            ],
          )),
    );
  }
}
