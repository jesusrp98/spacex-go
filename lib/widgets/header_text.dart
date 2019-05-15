import 'package:flutter/material.dart';

/// HEADER TEXT WIDGET
/// This widget is used in the 'Settings' & 'About' screens.
/// It categorizes items based on a theme.
class HeaderText extends StatelessWidget {
  final String text;

  const HeaderText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, top: 16),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: Theme.of(context).accentColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
