import 'package:flutter/material.dart';

import '../ui/views/general/index.dart';
import '../ui/views/launches/index.dart';
import '../ui/views/vehicles/index.dart';
import '../ui/widgets/index.dart';

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

          return ResponsivePageRoute(
            settings: routeSettings,
            builder: (_) => CorePage(
              launchId: launchId,
              coreId: coreId,
            ),
          );

        case CapsulePage.route:
          final launchId = args['launchId'] as String;

          return ResponsivePageRoute(
            settings: routeSettings,
            builder: (_) => CapsulePage(launchId: launchId),
          );

        case LaunchpadPage.route:
          final launchId = args['launchId'] as String;

          return ResponsivePageRoute(
            settings: routeSettings,
            builder: (_) => LaunchpadPage(launchId: launchId),
          );

        case LandpadPage.route:
          final launchId = args['launchId'] as String;
          final coreId = args['coreId'] as String;

          return ResponsivePageRoute(
            settings: routeSettings,
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

class ResponsivePageRoute extends PageRouteBuilder {
  ResponsivePageRoute({
    RouteSettings settings,
    @required WidgetBuilder builder,
    Color barrierColor = const Color(0x80000000),
    Duration transitionDuration = const Duration(milliseconds: 200),
    Curve transitionCurve = Curves.linear,
  }) : super(
          settings: settings,
          pageBuilder: (context, animation, _) => FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: transitionCurve,
            ),
            child: ResponsivePage(child: builder(context)),
          ),
          transitionDuration: transitionDuration,
          reverseTransitionDuration: transitionDuration,
          opaque: false,
          barrierDismissible: true,
          barrierColor: barrierColor,
          fullscreenDialog: true,
        );
}
