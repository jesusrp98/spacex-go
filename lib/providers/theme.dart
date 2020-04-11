import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/style.dart';

enum Themes { light, dark, black, system }

const Themes _defaultTheme = Themes.dark;

final Map<Themes, ThemeData> _themeData = {
  Themes.light: Style.light,
  Themes.dark: Style.dark,
  Themes.black: Style.black,
};

/// Saves and loads information regarding the theme setting.
class ThemeProvider with ChangeNotifier {
  static ThemeData _appThemeData = _themeData[_theme];
  static Themes _theme = _defaultTheme;

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

  /// Load theme information from local storage
  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      theme = Themes.values[prefs.getInt('theme')];
    } catch (e) {
      prefs.setInt('theme', Themes.values.indexOf(_defaultTheme));
    }

    notifyListeners();
  }
}
