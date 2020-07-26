import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/style.dart';

const Themes _defaultTheme = Themes.system;

enum Themes { light, dark, black, system }

final Map<Themes, ThemeData> _themeData = {
  Themes.light: Style.light,
  Themes.dark: Style.dark,
  Themes.black: Style.black,
};

/// Saves and loads information regarding the theme setting.
class ThemeProvider with ChangeNotifier {
  static Themes _theme = _defaultTheme;

  ThemeProvider() {
    init();
  }

  Themes get theme => _theme;

  set theme(Themes theme) {
    _theme = theme;
    notifyListeners();
  }

  /// Returns appropiate theme mode
  ThemeMode get themeMode {
    switch (_theme) {
      case Themes.light:
        return ThemeMode.light;
      case Themes.dark:
      case Themes.black:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  /// Default light theme
  ThemeData get lightTheme => _themeData[Themes.light];

  /// Default dark theme
  ThemeData get darkTheme => _theme == Themes.black
      ? _themeData[Themes.black]
      : _themeData[Themes.dark];

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
