import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scoped_model/scoped_model.dart';

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

/// CHERRY APP CLASS
/// Builds the app theme & home page
class CherryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: model,
      child: ScopedModelDescendant<AppModel>(
        builder: (context, child, model) => MaterialApp(
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
