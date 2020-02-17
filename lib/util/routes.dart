import 'package:big_tip/big_tip.dart';
import 'package:flutter/material.dart';

import '../ui/pages/index.dart';
import '../ui/screens/index.dart';

class Routes {
  static Map<String, WidgetBuilder> get staticRoutes => {
        '/': (_) => StartScreen(),
        '/settings': (_) => SettingsScreen(),
        '/about': (_) => AboutScreen(),
      };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/launch':
        if (args is Map<String, int>) {
          return MaterialPageRoute(
            builder: (_) => LaunchPage(args['id']),
          );
        }
        return errorRoute(settings);

      case '/vehicle':
        if (args is Map<String, String>) {
          final id = args['id'];
          return MaterialPageRoute(
            builder: (_) {
              switch (args['type']) {
                case 'rocket':
                  return RocketPage(id);
                  break;
                case 'capsule':
                  return DragonPage(id);
                  break;
                case 'ship':
                  return ShipPage(id);
                  break;
                default:
                  return RoadsterPage();
              }
            },
          );
        }
        return errorRoute(settings);

      default:
        return errorRoute(settings);
    }
  }

  static Route<dynamic> errorRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: BigTip(
          title: 'An error ocurred',
          subtitle: 'This page is not available',
          child: Icon(Icons.sentiment_very_dissatisfied),
        ),
      ),
    );
  }
}
