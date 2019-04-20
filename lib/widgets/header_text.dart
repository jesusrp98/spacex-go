import 'package:flutter/material.dart';

/// HEADER TEXT WIDGET
/// This widget is used in the 'Settings' & 'About' screens.
/// It categorizes items based on a theme.
class HeaderText extends StatelessWidget {
  final String text;

  HeaderText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16),
      child: Text(
        text,
        style: Theme.of(context).textTheme.subhead.copyWith(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
