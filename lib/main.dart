import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'models/app_model.dart';
import 'ui/screens/about.dart';
import 'ui/screens/settings.dart';
import 'ui/screens/start.dart';

/// Main app model
final AppModel model = AppModel();

/// Main app method
void main() async {
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
          theme: model.themeData,
          home: StartScreen(),
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
            '/about': (_) => AboutScreen(),
            '/settings': (_) => SettingsScreen(),
          },
          localizationsDelegates: [
            FlutterI18nDelegate(useCountryCode: false, fallbackFile: 'en'),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
        ),
      ),
    );
  }
}
