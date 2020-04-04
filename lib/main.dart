import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'providers/index.dart';
import 'repositories/index.dart';
import 'ui/screens/index.dart';

void main() => runApp(CherryApp());

/// Builds the neccesary providers, as well as the home page.
class CherryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ImageQualityProvider()),
        ChangeNotifierProvider(create: (_) => NotificationsProvider()),
        ChangeNotifierProvider(create: (_) => VehiclesRepository()),
        ChangeNotifierProvider(create: (_) => LaunchesRepository()),
        ChangeNotifierProvider(create: (_) => CompanyRepository()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, model, child) => MaterialApp(
          title: 'SpaceX GO!',
          theme: model.requestTheme(Themes.light),
          darkTheme: model.requestTheme(Themes.dark),
          home: StartScreen(),
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
            '/about': (_) => const AboutScreen(),
            '/settings': (_) => const SettingsScreen(),
          },
          localizationsDelegates: [
            FlutterI18nDelegate(
              translationLoader: FileTranslationLoader(fallbackFile: 'en'),
            ),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
        ),
      ),
    );
  }
}
