import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'providers/index.dart';
import 'repositories/index.dart';
import 'services/index.dart';
import 'util/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notificationsProvider = NotificationsProvider();
  await notificationsProvider.init();
  runApp(CherryApp(notificationsProvider));
}

/// Builds the neccesary providers, as well as the home page.
class CherryApp extends StatelessWidget {
  final NotificationsProvider notificationsProvider;
  final client = Dio();

  CherryApp(this.notificationsProvider);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ImageQualityProvider()),
        ChangeNotifierProvider(create: (_) => notificationsProvider),
        ChangeNotifierProvider(
          create: (_) => VehiclesRepository(
            VehiclesService(client),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => LaunchesRepository(
            LaunchesService(client),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => CompanyRepository(
            CompanyService(client),
          ),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, model, child) => MaterialApp(
          title: 'SpaceX GO!',
          theme: model.lightTheme,
          darkTheme: model.darkTheme,
          themeMode: model.themeMode,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routes.generateRoute,
          onUnknownRoute: Routes.errorRoute,
          localizationsDelegates: [
            FlutterI18nDelegate(
              translationLoader: FileTranslationLoader(),
            )..load(null),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
        ),
      ),
    );
  }
}
