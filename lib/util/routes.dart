import 'package:flutter/material.dart';

import '../ui/pages/index.dart';
import '../ui/pages/vehicle/index.dart';
import '../ui/screens/index.dart';

/// Class that holds both route names & generate methods.
/// Used by the Flutter routing system
class Routes {
  /// Methods that generate all routes
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    try {
      final Map<String, dynamic> args = routeSettings.arguments;

      switch (routeSettings.name) {
        case StartScreen.route:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => StartScreen(),
          );

        case AboutScreen.route:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => AboutScreen(),
          );

        case ChangelogScreen.route:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => ChangelogScreen(),
          );

        case SettingsScreen.route:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => SettingsScreen(),
          );

        case LaunchPage.route:
          final id = args['id'] as String;

          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => LaunchPage(id),
          );

        case CorePage.route:
          final launchId = args['launchId'] as String;
          final coreId = args['coreId'] as String;

          return MaterialPageRoute(
            settings: routeSettings,
            fullscreenDialog: true,
            builder: (_) => CorePage(
              launchId: launchId,
              coreId: coreId,
            ),
          );

        case CapsulePage.route:
          final launchId = args['launchId'] as String;

          return MaterialPageRoute(
            settings: routeSettings,
            fullscreenDialog: true,
            builder: (_) => CapsulePage(launchId: launchId),
          );

        case LaunchpadPage.route:
          final launchId = args['launchId'] as String;

          return MaterialPageRoute(
            settings: routeSettings,
            fullscreenDialog: true,
            builder: (_) => LaunchpadPage(launchId: launchId),
          );

        case LandpadPage.route:
          final launchId = args['launchId'] as String;
          final coreId = args['coreId'] as String;

          return MaterialPageRoute(
            settings: routeSettings,
            fullscreenDialog: true,
            builder: (_) => LandpadPage(
              launchId: launchId,
              coreId: coreId,
            ),
          );

        case VehiclePage.route:
          final id = args['id'] as String;

          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => VehiclePage(vehicleId: id),
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
