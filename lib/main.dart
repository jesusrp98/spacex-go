import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'providers/index.dart';
import 'repositories/index.dart';
import 'services/index.dart';
import 'util/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final httpClient = Dio();

  final notificationsProvider = NotificationsProvider(
    FlutterLocalNotificationsPlugin(),
    notificationDetails: NotificationDetails(
      android: AndroidNotificationDetails(
        'channel.launches',
        'Launches notifications',
        'Stay up-to-date with upcoming SpaceX launches',
        importance: Importance.high,
      ),
      iOS: IOSNotificationDetails(),
    ),
    initializationSettings: InitializationSettings(
      android: AndroidInitializationSettings('notification_launch'),
      iOS: IOSInitializationSettings(),
    ),
  );
  await notificationsProvider.init();

  runApp(CherryApp(
    themeProvider: ThemeProvider(),
    imageQualityProvider: ImageQualityProvider(),
    notificationsProvider: notificationsProvider,
    vehiclesRepository: VehiclesRepository(VehiclesService(httpClient)),
    launchesRepository: LaunchesRepository(LaunchesService(httpClient)),
    companyRepository: CompanyRepository(CompanyService(httpClient)),
  ));
}

/// Builds the neccesary providers, as well as the home page.
class CherryApp extends StatelessWidget {
  final ThemeProvider themeProvider;
  final ImageQualityProvider imageQualityProvider;
  final NotificationsProvider notificationsProvider;
  final VehiclesRepository vehiclesRepository;
  final LaunchesRepository launchesRepository;
  final CompanyRepository companyRepository;

  const CherryApp({
    this.themeProvider,
    this.imageQualityProvider,
    this.notificationsProvider,
    this.vehiclesRepository,
    this.launchesRepository,
    this.companyRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => themeProvider),
        ChangeNotifierProvider(create: (_) => imageQualityProvider),
        ChangeNotifierProvider(create: (_) => notificationsProvider),
        ChangeNotifierProvider(create: (_) => vehiclesRepository),
        ChangeNotifierProvider(create: (_) => launchesRepository),
        ChangeNotifierProvider(create: (_) => companyRepository),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, model, child) => MaterialApp(
          title: 'SpaceX GO!',
          theme: model.lightTheme,
          darkTheme: model.darkTheme,
          themeMode: model.themeMode,
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
