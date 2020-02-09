import 'package:big_tip/big_tip.dart';
import 'package:flutter/material.dart';

import '../ui/screens/index.dart';

class Routes {
  static Map<String, WidgetBuilder> get staticRoutes => {
        '/': (_) => StartScreen(),
        '/settings': (_) => SettingsScreen(),
        '/about': (_) => AboutScreen(),
      };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    // switch (settings.name) {
    //   case '/':
    //     return MaterialPageRoute(builder: (_) => StartScreen());
    //   case '/settings':
    //     return MaterialPageRoute(builder: (_) => SettingsScreen());
    //   case '/about':
    //     return MaterialPageRoute(builder: (_) => AboutScreen());
    //   default:
    //     return errorRoute(settings);
    // }
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
