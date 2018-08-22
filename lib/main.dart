import 'package:cherry/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:cherry/colors.dart';

/// Main app method
void main() => runApp(CherryApp());

/// CHERRY APP CLASS
/// Builds the app theme & home page
class CherryApp extends StatelessWidget {
  /// Builds the app theme
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
      title: 'SpaceX GO!',
      theme: _buildThemeData(),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
