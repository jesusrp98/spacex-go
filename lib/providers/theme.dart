import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/colors.dart';

enum Themes { light, dark, black, system }

final Map<Themes, ThemeData> _themeData = {
  Themes.light: ThemeData(
    brightness: Brightness.light,
    primaryColor: lightPrimaryColor,
    accentColor: lightAccentColor,
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),
  ),
  Themes.dark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkPrimaryColor,
    accentColor: darkAccentColor,
    canvasColor: darkCanvasColor,
    scaffoldBackgroundColor: darkBackgroundColor,
    cardColor: darkCardColor,
    dividerColor: darkDividerColor,
    dialogBackgroundColor: darkCardColor,
    popupMenuTheme: PopupMenuThemeData(
      color: darkCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),
  ),
  Themes.black: ThemeData(
    brightness: Brightness.dark,
    primaryColor: blackPrimaryColor,
    accentColor: blackAccentColor,
    canvasColor: blackBackgroundColor,
    scaffoldBackgroundColor: blackBackgroundColor,
    cardColor: blackCardColor,
    dividerColor: blackDividerColor,
    dialogBackgroundColor: darkCardColor,
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(color: blackDividerColor),
      ),
    ),
  )
};

class ThemeProvider with ChangeNotifier {
  static Themes _theme = Themes.dark;
  static ThemeData _appThemeData = _themeData[_theme];

  ThemeProvider() {
    init();
  }

  Themes get theme => _theme;
  set theme(Themes theme) {
    if (theme != null) {
      _theme = theme;
      _appThemeData = _themeData[theme];
      notifyListeners();
    }
  }

  /// Returns the app's theme depending on the device's settings
  ThemeData requestTheme(Themes fallback) =>
      theme == Themes.system ? _themeData[fallback] : _appThemeData;

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      theme = Themes.values[prefs.getInt('theme')];
    } catch (e) {
      prefs.setInt('theme', 1);
    }

    notifyListeners();
  }
}
