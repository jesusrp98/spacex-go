import 'package:flutter/material.dart';

import '../ui/pages/index.dart';
import '../ui/screens/index.dart';

/// Class that holds both route names & generate methods.
/// Used by the Flutter routing system
class Routes {
  // Static route names
  static const home = '/';
  static const about = '/about';
  static const settings = '/settings';
  static const launch = '/launch';
  static const vehicle = '/vehicle';

  /// Methods that generate all routes
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    try {
      final Map<String, dynamic> args = routeSettings.arguments;

      switch (routeSettings.name) {
        case home:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => StartScreen(),
          );

        case about:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => AboutScreen(),
          );

        case settings:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => SettingsScreen(),
          );

        case launch:
          final id = args['id'] as String;

          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => LaunchPage(id),
          );

        case vehicle:
          final id = args['id'] as String;
          final type = args['type'] as String;

          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) {
              switch (type) {
                case 'rocket':
                  return RocketPage(id);
                case 'capsule':
                  return DragonPage(id);
                case 'ship':
                  return ShipPage(id);
                case 'roadster':
                  return RoadsterPage(id);
                default:
                  return ErrorScreen();
              }
            },
          );

        default:
          return errorRoute(routeSettings);
      }
    } catch (_) {
      return errorRoute(routeSettings);
    }
  }

  /// Method that calles the error screen when neccesary
  static Route<dynamic> errorRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (_) => ErrorScreen(),
    );
  }
}
