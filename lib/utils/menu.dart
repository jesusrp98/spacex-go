import '../ui/views/general/index.dart';

/// Contains all possible popupmenus' strings
class Menu {
  static const home = {
    'app.menu.about': AboutScreen.route,
    'app.menu.settings': SettingsScreen.route,
  };

  static const launch = [
    'spacex.launch.menu.reddit',
    'spacex.launch.menu.press_kit',
  ];

  static const wikipedia = [
    'spacex.other.menu.wikipedia',
  ];

  static const ship = [
    'spacex.other.menu.marine_traffic',
  ];
}
