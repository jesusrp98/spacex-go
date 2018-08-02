import 'package:cherry/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:cherry/colors.dart';

void main() => runApp(CherryApp());

class CherryApp extends StatelessWidget {
  ThemeData _buildThemeData() => ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'ProductSans',
        primaryColor: primaryColor,
        accentColor: accentColor,
        canvasColor: backgroundColor,
        cardColor: cardColor,
        dialogBackgroundColor: cardColor,
        dividerColor: dividerColor,
        highlightColor: highlightColor,
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Project: Cherry',
        theme: _buildThemeData(),
        home: HomePage());
  }
}