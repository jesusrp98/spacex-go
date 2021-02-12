import 'package:cherry_components/cherry_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:row_collection/row_collection.dart';
import 'package:system_setting/system_setting.dart';

import '../../cubits/index.dart';
import '../widgets/index.dart';

/// Here lays all available options for the user to configurate.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  static const route = '/settings';

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: FlutterI18n.translate(context, 'app.menu.settings'),
      body: ListView(
        children: <Widget>[
          HeaderText(
            FlutterI18n.translate(
              context,
              'settings.headers.general',
            ),
            head: true,
          ),
          BlocConsumer<ThemeCubit, ThemeState>(
            listener: (context, state) => Navigator.of(context).pop(),
            builder: (context, state) => ListCell.icon(
              icon: Icons.palette,
              title: FlutterI18n.translate(
                context,
                'settings.theme.title',
              ),
              subtitle: FlutterI18n.translate(
                context,
                'settings.theme.body',
              ),
              onTap: () => showBottomRoundDialog(
                context: context,
                title: FlutterI18n.translate(
                  context,
                  'settings.theme.title',
                ),
                children: <Widget>[
                  RadioCell<ThemeState>(
                    title: FlutterI18n.translate(
                      context,
                      'settings.theme.theme.dark',
                    ),
                    groupValue: state,
                    value: ThemeState.dark,
                    onChanged: (value) => updateTheme(context, value),
                  ),
                  RadioCell<ThemeState>(
                    title: FlutterI18n.translate(
                      context,
                      'settings.theme.theme.black',
                    ),
                    groupValue: state,
                    value: ThemeState.black,
                    onChanged: (value) => updateTheme(context, value),
                  ),
                  RadioCell<ThemeState>(
                    title: FlutterI18n.translate(
                      context,
                      'settings.theme.theme.light',
                    ),
                    groupValue: state,
                    value: ThemeState.light,
                    onChanged: (value) => updateTheme(context, value),
                  ),
                  RadioCell<ThemeState>(
                    title: FlutterI18n.translate(
                      context,
                      'settings.theme.theme.system',
                    ),
                    groupValue: state,
                    value: ThemeState.system,
                    onChanged: (value) => updateTheme(context, value),
                  ),
                ],
              ),
            ),
          ),
          Separator.divider(indent: 72),
          BlocConsumer<BrowserCubit, BrowserType>(
            listener: (context, state) => Navigator.of(context).pop(),
              builder: (context, state) =>ListCell.icon(
                icon: Icons.auto_awesome_mosaic,
                title: FlutterI18n.translate(
                    context,
                    'settings.internal_browser.title'
                ),
                onTap: () => showBottomRoundDialog(
                  context: context,
                  title: FlutterI18n.translate(context, 'settings.internal_browser.title'),
                  children: <Widget>[
                    RadioCell<BrowserType>(
                      title: FlutterI18n.translate(
                        context,
                        'settings.internal_browser.internal_browser',
                      ),
                      groupValue: state,
                      value: BrowserType.inApp,
                      onChanged: (value) => updateBrowserType(context, value),
                    ),

                    RadioCell<BrowserType>(
                      title: FlutterI18n.translate(
                        context,
                        'settings.internal_browser.external_browser',
                      ),
                      groupValue: state,
                      value: BrowserType.system,
                      onChanged: (value) => updateBrowserType(context, value),
                    ),
                  ],
                ),
              )
          ),

          Separator.divider(indent: 72),
          BlocConsumer<ImageQualityCubit, ImageQuality>(
            listener: (context, state) => Navigator.of(context).pop(),
            builder: (context, state) => ListCell.icon(
              icon: Icons.photo_filter,
              title: FlutterI18n.translate(
                context,
                'settings.image_quality.title',
              ),
              subtitle: FlutterI18n.translate(
                context,
                'settings.image_quality.body',
              ),
              onTap: () => showBottomRoundDialog(
                context: context,
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
                    groupValue: state,
                    value: ImageQuality.low,
                    onChanged: (value) => updateImageQuality(context, value),
                  ),
                  RadioCell<ImageQuality>(
                    title: FlutterI18n.translate(
                      context,
                      'settings.image_quality.quality.medium',
                    ),
                    groupValue: state,
                    value: ImageQuality.medium,
                    onChanged: (value) => updateImageQuality(context, value),
                  ),
                  RadioCell<ImageQuality>(
                    title: FlutterI18n.translate(
                      context,
                      'settings.image_quality.quality.high',
                    ),
                    groupValue: state,
                    value: ImageQuality.high,
                    onChanged: (value) => updateImageQuality(context, value),
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
            onTap: () => SystemSetting.goto(SettingTarget.NOTIFICATION),
          ),
          Separator.divider(indent: 72),
        ],
      ),
    );
  }

  static void updateTheme(BuildContext context, ThemeState value) =>
      context.read<ThemeCubit>().theme = value;

  static void updateImageQuality(BuildContext context, ImageQuality value) =>
      context.read<ImageQualityCubit>().imageQuality = value;

  static void updateBrowserType(BuildContext context, BrowserType value) =>
      context.read<BrowserCubit>().browserType = value;
}
