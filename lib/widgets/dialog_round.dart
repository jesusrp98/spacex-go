import 'package:flutter/material.dart';

class RoundDialog extends StatelessWidget {
  final String title;
  final List<Widget> children;

  RoundDialog({this.title, this.children});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        title.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .title
            .copyWith(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      children: children,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}
