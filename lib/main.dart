import 'package:cherry/cubits/index.dart';
import 'package:cherry/repositories/index.dart';
import 'package:cherry/services/index.dart';
import 'package:cherry/utils/index.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBlocOverrides.runZoned(
    () {
      final httpClient = Dio();

      // final notificationsCubit = kIsWeb
      //     ? null
      //     : NotificationsCubit(
      //         FlutterLocalNotificationsPlugin(),
      //         notificationDetails: NotificationDetails(
      //           android: AndroidNotificationDetails(
      //             'channel.launches',
      //             'Launches notifications',
      //             'Stay up-to-date with upcoming SpaceX launches',
      //             importance: Importance.high,
      //           ),
      //           iOS: IOSNotificationDetails(),
      //         ),
      //         initializationSettings: InitializationSettings(
      //           android: AndroidInitializationSettings('notification_launch'),
      //           iOS: IOSInitializationSettings(),
      //         ),
      //       );
      // await notificationsCubit?.init();

      runApp(
        CherryApp(
          // notificationsCubit: notificationsCubit,
          vehiclesRepository: VehiclesRepository(
            VehiclesService(httpClient),
          ),
          launchesRepository: LaunchesRepository(
            LaunchesService(httpClient),
          ),
          achievementsRepository: AchievementsRepository(
            AchievementsService(httpClient),
          ),
          companyRepository: CompanyRepository(
            CompanyService(httpClient),
          ),
          changelogRepository: ChangelogRepository(
            ChangelogService(httpClient),
          ),
        ),
      );
    },
    storage: await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory(),
    ),
    blocObserver: CherryBlocObserver(),
  );
}

/// Builds the neccesary cubits, as well as the home page.
class CherryApp extends StatelessWidget {
  // final NotificationsCubit notificationsCubit;
  final VehiclesRepository vehiclesRepository;
  final LaunchesRepository launchesRepository;
  final AchievementsRepository achievementsRepository;
  final CompanyRepository companyRepository;
  final ChangelogRepository changelogRepository;

  const CherryApp({
    // this.notificationsCubit,
    required this.vehiclesRepository,
    required this.launchesRepository,
    required this.achievementsRepository,
    required this.companyRepository,
    required this.changelogRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => ImageQualityCubit()),
        BlocProvider(create: (_) => BrowserCubit()),
        // BlocProvider.value(value: notificationsCubit),
        BlocProvider(create: (_) => vehiclesRepository),
        BlocProvider(create: (_) => launchesRepository),
        BlocProvider(create: (_) => achievementsRepository),
        BlocProvider(create: (_) => companyRepository),
        BlocProvider(create: (_) => changelogRepository),
      ],
      child: BlocConsumer<ThemeCubit, ThemeState>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          title: 'SpaceX GO!',
          theme: context.watch<ThemeCubit>().lightTheme,
          darkTheme: context.watch<ThemeCubit>().darkTheme,
          themeMode: context.watch<ThemeCubit>().themeMode,
          onGenerateRoute: Routes.generateRoute,
          onUnknownRoute: Routes.errorRoute,
          localizationsDelegates: [
            FlutterI18nDelegate(
              translationLoader: FileTranslationLoader(),
            ),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
        ),
      ),
    );
  }
}
