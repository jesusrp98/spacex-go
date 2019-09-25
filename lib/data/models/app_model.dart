import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/colors.dart';

enum Themes { light, dark, black, system }
enum ImageQuality { low, medium, high }

/// Specific general settings about the app.
class AppModel with ChangeNotifier {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  // Light, dark & OLED themes
  static final List<ThemeData> _themes = [
    ThemeData(
      brightness: Brightness.light,
      primaryColor: lightPrimaryColor,
      accentColor: lightAccentColor,
      popupMenuTheme: PopupMenuThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    ),
    ThemeData(
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
    ThemeData(
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
  ];

  ImageQuality _imageQuality = ImageQuality.medium;

  ImageQuality get imageQuality => _imageQuality;

  set imageQuality(ImageQuality imageQuality) {
    _imageQuality = imageQuality;
    notifyListeners();
  }

  FlutterLocalNotificationsPlugin get notifications => _notifications;

  Themes _theme = Themes.dark;

  ThemeData _themeData = _themes[1];

  Themes get theme => _theme;

  set theme(Themes theme) {
    if (theme != null) {
      _theme = theme;
      themeData = theme;
      notifyListeners();
    }
  }

  // ignore: mismatched_getter_and_setter_types
  ThemeData get themeData => _themeData;

  set themeData(Themes theme) {
    if (theme != Themes.system) _themeData = _themes[theme.index];
    notifyListeners();
  }

  /// Returns the app's theme depending on the device's settings
  ThemeData requestTheme(Brightness fallback) => theme == Themes.system
      ? fallback == Brightness.dark ? _themes[1] : _themes[0]
      : themeData;

  /// Method that initializes the [AppModel] itself.
  Future init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Loads the theme
    try {
      theme = Themes.values[prefs.getInt('theme')];
    } catch (e) {
      prefs.setInt('theme', 1);
    }

    // Loads image quality
    try {
      imageQuality = ImageQuality.values[prefs.getInt('quality')];
    } catch (e) {
      prefs.setInt('quality', 1);
    }

    // Inits notifications system
    notifications.initialize(const InitializationSettings(
      AndroidInitializationSettings('notification_launch'),
      IOSInitializationSettings(),
    ));

    notifyListeners();
  }
}
