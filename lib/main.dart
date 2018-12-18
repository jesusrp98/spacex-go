import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/screen_about.dart';
import 'screens/screen_spacex.dart';
import 'util/colors.dart';

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
      title: FlutterI18n.translate(context, 'app.title'),
      theme: _buildThemeData(),
      home: SpacexScreen(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/info': (_) => AboutScreen(),
      },
      localizationsDelegates: [
        FlutterI18nDelegate(false, 'en'),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
    );
  }
}
