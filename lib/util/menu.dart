import 'routes.dart';

/// Contains all possible popupmenus' strings
class Menu {
  static const home = {
    'app.menu.about': Routes.about,
    'app.menu.settings': Routes.settings,
  };

  static const launch = [
    'spacex.launch.menu.reddit',
    'spacex.launch.menu.press_kit',
    'spacex.launch.menu.article',
  ];

  static const wikipedia = [
    'spacex.other.menu.wikipedia',
  ];

  static const ship = [
    'spacex.other.menu.marine_traffic',
  ];
}
