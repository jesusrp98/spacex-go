import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'data/models/index.dart';
import 'ui/screens/index.dart';

/// Main app model
final AppModel model = AppModel();

/// Main app method
Future<void> main() async {
  await model.init();
  runApp(CherryApp());
}

/// Builds the app theme & home page
class CherryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppModel>(
      builder: (context) => model,
      child: Consumer<AppModel>(
        builder: (context, model, child) => MaterialApp(
          title: 'SpaceX GO!',
          theme: model.requestTheme(Brightness.light),
          darkTheme: model.requestTheme(Brightness.dark),
          home: StartScreen(),
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
            '/about': (_) => const AboutScreen(),
            '/settings': (_) => const SettingsScreen(),
          },
          localizationsDelegates: [
            FlutterI18nDelegate(fallbackFile: 'en'),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
        ),
      ),
    );
  }
}
