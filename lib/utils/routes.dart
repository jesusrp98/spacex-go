import 'package:flutter/material.dart';

import '../ui/views/general/index.dart';
import '../ui/views/launches/index.dart';
import '../ui/views/vehicles/index.dart';
import '../ui/widgets/index.dart';

//Animation for route
dynamic animateRoute(RouteSettings pageSetting, Widget routeName) {
  return PageRouteBuilder(
    settings: pageSetting,
    pageBuilder: (context, animation, secondaryAnimation) => routeName,
    transitionDuration: Duration(milliseconds: 600),
    reverseTransitionDuration: Duration(milliseconds: 600),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

/// Class that holds both route names & generate methods.
/// Used by the Flutter routing system
class Routes {
  /// Methods that generate all routes
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    try {
      final Map<String, dynamic> args = routeSettings.arguments;

      switch (routeSettings.name) {
        case StartScreen.route:
          return animateRoute(routeSettings, StartScreen());
        // return MaterialPageRoute(
        //   settings: routeSettings,
        //   builder: (_) => StartScreen(),
        // );

        case AboutScreen.route:
          return animateRoute(routeSettings, AboutScreen());

        // return MaterialPageRoute(
        //   settings: routeSettings,
        //   builder: (_) => AboutScreen(),
        // );

        case ChangelogScreen.route:
          return animateRoute(routeSettings, ChangelogScreen());

        // return MaterialPageRoute(
        //   settings: routeSettings,
        //   builder: (_) => ChangelogScreen(),
        // );

        case SettingsScreen.route:
          return animateRoute(routeSettings, SettingsScreen());

        // return MaterialPageRoute(
        //   settings: routeSettings,
        //   builder: (_) => SettingsScreen(),
        // );

        case LaunchPage.route:
          final id = args['id'] as String;
          return animateRoute(routeSettings, LaunchPage(id));

        // return MaterialPageRoute(
        //   settings: routeSettings,
        //   builder: (_) => LaunchPage(id),
        // );

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
          return animateRoute(routeSettings, VehiclePage(vehicleId: id));

        // return MaterialPageRoute(
        //   settings: routeSettings,
        //   builder: (_) => VehiclePage(vehicleId: id),
        // );

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
