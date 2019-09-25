import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_setting/system_setting.dart';

import '../../data/models/index.dart';
import '../widgets/index.dart';

/// Here lays all available options for the user to configurate.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Settings indexes
  ImageQuality _imageQualityIndex;
  Themes _themeIndex;

  @override
  void initState() {
    // Get the app theme & image quality from the 'AppModel' model.
    Future.delayed(Duration.zero, () async {
      _themeIndex = Provider.of<AppModel>(context).theme;
      _imageQualityIndex = Provider.of<AppModel>(context).imageQuality;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlanckPage(
      title: FlutterI18n.translate(context, 'app.menu.settings'),
      body: Consumer<AppModel>(
        builder: (context, model, child) => ListView(
          children: <Widget>[
            HeaderText(FlutterI18n.translate(
              context,
              'settings.headers.general',
            )),
            ListCell.icon(
              icon: Icons.palette,
              title: FlutterI18n.translate(
                context,
                'settings.theme.title',
              ),
              subtitle: FlutterI18n.translate(
                context,
                'settings.theme.body',
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () => showDialog(
                context: context,
                builder: (context) => RoundDialog(
                  title: FlutterI18n.translate(
                    context,
                    'settings.theme.title',
                  ),
                  children: <Widget>[
                    RadioCell<Themes>(
                      title: FlutterI18n.translate(
                        context,
                        'settings.theme.theme.dark',
                      ),
                      groupValue: _themeIndex,
                      value: Themes.dark,
                      onChanged: (value) => _changeTheme(value),
                    ),
                    RadioCell<Themes>(
                      title: FlutterI18n.translate(
                        context,
                        'settings.theme.theme.black',
                      ),
                      groupValue: _themeIndex,
                      value: Themes.black,
                      onChanged: (value) => _changeTheme(value),
                    ),
                    RadioCell<Themes>(
                      title: FlutterI18n.translate(
                        context,
                        'settings.theme.theme.light',
                      ),
                      groupValue: _themeIndex,
                      value: Themes.light,
                      onChanged: (value) => _changeTheme(value),
                    ),
                    RadioCell<Themes>(
                      title: FlutterI18n.translate(
                        context,
                        'settings.theme.theme.system',
                      ),
                      groupValue: _themeIndex,
                      value: Themes.system,
                      onChanged: (value) => _changeTheme(value),
                    ),
                  ],
                ),
              ),
            ),
            Separator.divider(indent: 72),
            ListCell.icon(
              icon: Icons.photo_filter,
              title: FlutterI18n.translate(
                context,
                'settings.image_quality.title',
              ),
              subtitle: FlutterI18n.translate(
                context,
                'settings.image_quality.body',
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () => showDialog(
                context: context,
                builder: (_) => RoundDialog(
                  title: FlutterI18n.translate(
                    context,
                    'settings.image_quality.title',
                  ),
                  children: <Widget>[
                    RadioCell<ImageQuality>(
                      title: FlutterI18n.translate(
                        context,
                        'settings.image_quality.quality.low',
                      ),
                      groupValue: _imageQualityIndex,
                      value: ImageQuality.low,
                      onChanged: (value) => _changeImageQuality(value),
                    ),
                    RadioCell<ImageQuality>(
                      title: FlutterI18n.translate(
                        context,
                        'settings.image_quality.quality.medium',
                      ),
                      groupValue: _imageQualityIndex,
                      value: ImageQuality.medium,
                      onChanged: (value) => _changeImageQuality(value),
                    ),
                    RadioCell<ImageQuality>(
                      title: FlutterI18n.translate(
                        context,
                        'settings.image_quality.quality.high',
                      ),
                      groupValue: _imageQualityIndex,
                      value: ImageQuality.high,
                      onChanged: (value) => _changeImageQuality(value),
                    ),
                  ],
                ),
              ),
            ),
            HeaderText(FlutterI18n.translate(
              context,
              'settings.headers.services',
            )),
            ListCell.icon(
              icon: Icons.notifications,
              title: FlutterI18n.translate(
                context,
                'settings.notifications.title',
              ),
              subtitle: FlutterI18n.translate(
                context,
                'settings.notifications.body',
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () => SystemSetting.goto(SettingTarget.NOTIFICATION),
            ),
            Separator.divider(indent: 72),
          ],
        ),
      ),
    );
  }

  // Updates app's theme
  Future<void> _changeTheme(Themes theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Saves new settings
    Provider.of<AppModel>(context).theme = theme;
    prefs.setInt('theme', theme.index);

    // Updates UI
    setState(() => _themeIndex = theme);

    // Hides dialog
    Navigator.of(context).pop();
  }

  // Updates image quality setting
  Future<void> _changeImageQuality(ImageQuality quality) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Saves new settings
    Provider.of<AppModel>(context).imageQuality = quality;
    prefs.setInt('quality', quality.index);

    // Updates UI
    setState(() => _imageQualityIndex = quality);

    // Hides dialog
    Navigator.of(context).pop();
  }
}
