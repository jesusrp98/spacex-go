import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:row_collection/row_collection.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_setting/system_setting.dart';

import '../../models/app_model.dart';
import '../../widgets/dialog_round.dart';
import '../../widgets/header_text.dart';
import '../../widgets/list_cell.dart';

/// SETTINGS SCREEN
/// Here lays all available options for the user to configurate.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Local variables used in setting's toggles
  bool _darkTheme = false;
  bool _oledBlack = false;

  // Image quality index
  ImageQuality _imageQualityIndex = ImageQuality.medium;

  @override
  void initState() {
    // Get the app theme & image quality from the 'AppModel' model.
    Themes _theme = ScopedModel.of<AppModel>(context)?.theme ?? Themes.dark;
    _imageQualityIndex = ScopedModel.of<AppModel>(context).imageQuality;

    // Update local variables according to the theme
    if (_theme == Themes.light)
      setState(() {
        _darkTheme = false;
        _oledBlack = false;
      });
    else if (_theme == Themes.black)
      setState(() {
        _darkTheme = true;
        _oledBlack = true;
      });
    else
      setState(() {
        _darkTheme = true;
        _oledBlack = false;
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(
          context,
          'app.menu.settings',
        )),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<AppModel>(
        builder: (context, _, model) => ListView(
              children: <Widget>[
                HeaderText(FlutterI18n.translate(
                  context,
                  'settings.headers.theme',
                )),
                ListCell.icon(
                  icon: Icons.brightness_6,
                  title: FlutterI18n.translate(
                    context,
                    'settings.dark_theme.title',
                  ),
                  subtitle: FlutterI18n.translate(
                    context,
                    'settings.dark_theme.body',
                  ),
                  trailing: Switch(
                    activeColor: Theme.of(context).accentColor,
                    value: _darkTheme,
                    onChanged: (value) => _changeTheme(
                          model: model,
                          theme: value
                              ? _oledBlack ? Themes.black : Themes.dark
                              : Themes.light,
                        ),
                  ),
                ),
                Separator.divider(indent: 72),
                ListCell.icon(
                  icon: Icons.brightness_2,
                  title: FlutterI18n.translate(
                    context,
                    'settings.oled_black.title',
                  ),
                  subtitle: FlutterI18n.translate(
                    context,
                    'settings.oled_black.body',
                  ),
                  trailing: Switch(
                    activeColor: Theme.of(context).accentColor,
                    value: _oledBlack,
                    onChanged: (value) => _changeTheme(
                          model: model,
                          theme: value ? Themes.black : Themes.dark,
                        ),
                  ),
                ),
                HeaderText(FlutterI18n.translate(
                  context,
                  'settings.headers.services',
                )),
                ListCell.icon(
                  icon: Icons.photo_filter,
                  title: FlutterI18n.translate(
                    context,
                    'settings.image_quality.title',
                  ),
                  subtitle: FlutterI18n.translate(
                    context,
                    'settings.image_quality.body',
                    {
                      'quality': _imageQualityIndex == ImageQuality.low
                          ? FlutterI18n.translate(
                              context,
                              'settings.image_quality.quality.low',
                            ).toLowerCase()
                          : _imageQualityIndex == ImageQuality.medium
                              ? FlutterI18n.translate(
                                  context,
                                  'settings.image_quality.quality.medium',
                                ).toLowerCase()
                              : FlutterI18n.translate(
                                  context,
                                  'settings.image_quality.quality.high',
                                ).toLowerCase(),
                    },
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
                                RadioListTile<ImageQuality>(
                                  title: Text(
                                    FlutterI18n.translate(
                                      context,
                                      'settings.image_quality.quality.low',
                                    ),
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  dense: true,
                                  groupValue: _imageQualityIndex,
                                  activeColor: Theme.of(context).accentColor,
                                  value: ImageQuality.low,
                                  onChanged: (value) => _changeImageQuality(
                                        model: model,
                                        quality: value,
                                      ),
                                ),
                                RadioListTile<ImageQuality>(
                                  title: Text(
                                    FlutterI18n.translate(
                                      context,
                                      'settings.image_quality.quality.medium',
                                    ),
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  dense: true,
                                  groupValue: _imageQualityIndex,
                                  activeColor: Theme.of(context).accentColor,
                                  value: ImageQuality.medium,
                                  onChanged: (value) => _changeImageQuality(
                                        model: model,
                                        quality: value,
                                      ),
                                ),
                                RadioListTile<ImageQuality>(
                                  title: Text(
                                    FlutterI18n.translate(
                                      context,
                                      'settings.image_quality.quality.high',
                                    ),
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  dense: true,
                                  groupValue: _imageQualityIndex,
                                  activeColor: Theme.of(context).accentColor,
                                  value: ImageQuality.high,
                                  onChanged: (value) => _changeImageQuality(
                                        model: model,
                                        quality: value,
                                      ),
                                )
                              ],
                            ),
                      ),
                ),
                Separator.divider(indent: 72),
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
  void _changeTheme({AppModel model, Themes theme}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Saves new settings
    prefs.setInt('theme', theme.index);
    model.theme = theme;

    // Updated UI
    if (theme == Themes.dark)
      setState(() {
        _darkTheme = true;
        _oledBlack = false;
      });
    else if (theme == Themes.black)
      setState(() {
        _darkTheme = true;
        _oledBlack = true;
      });
    else
      setState(() {
        _darkTheme = false;
        _oledBlack = false;
      });
  }

  // Updates image quality setting
  void _changeImageQuality({AppModel model, ImageQuality quality}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Saves new settings
    prefs.setInt('quality', quality.index);
    model.imageQuality = quality;

    // Updated UI
    setState(() => _imageQualityIndex = quality);

    // Hides dialog
    Navigator.of(context).pop();
  }
}
