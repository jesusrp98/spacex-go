import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/colors.dart';

enum Themes { light, dark, black }
enum ImageQuality { low, medium, high }

/// APP MODEL
/// Specific general settings about the app.
class AppModel extends Model {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static final String font =
      DateTime.now().month == 4 && DateTime.now().day == 1
          ? 'ComicSans'
          : 'ProductSans';

  static final List<ThemeData> _themes = [
    ThemeData(
      brightness: Brightness.light,
      fontFamily: font,
      primaryColor: lightPrimaryColor,
      accentColor: lightAccentColor,
    ),
    ThemeData(
      brightness: Brightness.dark,
      fontFamily: font,
      primaryColor: darkPrimaryColor,
      accentColor: darkAccentColor,
      canvasColor: darkCanvasColor,
      scaffoldBackgroundColor: darkBackgroundColor,
      cardColor: darkCardColor,
      dividerColor: darkDividerColor,
      dialogBackgroundColor: darkCardColor,
    ),
    ThemeData(
      brightness: Brightness.dark,
      fontFamily: font,
      primaryColor: blackPrimaryColor,
      accentColor: blackAccentColor,
      canvasColor: blackBackgroundColor,
      scaffoldBackgroundColor: blackBackgroundColor,
      cardColor: blackCardColor,
      dividerColor: blackDividerColor,
      dialogBackgroundColor: darkCardColor,
    )
  ];

  ImageQuality _imageQuality = ImageQuality.medium;

  get imageQuality => _imageQuality;

  set imageQuality(ImageQuality imageQuality) {
    _imageQuality = imageQuality;
    notifyListeners();
  }

  FlutterLocalNotificationsPlugin get notifications => _notifications;

  Themes _theme = Themes.dark;

  ThemeData _themeData = _themes[1];

  get theme => _theme;

  set theme(Themes theme) {
    if (theme != null) {
      _theme = theme;
      themeData = theme;
      notifyListeners();
    }
  }

  get themeData => _themeData;

  set themeData(Themes theme) {
    _themeData = _themes[theme.index];
    notifyListeners();
  }

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
    notifications.initialize(InitializationSettings(
      AndroidInitializationSettings('notification_launch'),
      IOSInitializationSettings(),
    ));

    notifyListeners();
  }
}
