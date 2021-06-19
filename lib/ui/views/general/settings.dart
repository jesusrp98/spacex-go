import 'package:cherry_components/cherry_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:row_collection/row_collection.dart';
import 'package:system_setting/system_setting.dart';

import '../../../cubits/index.dart';
import '../../../utils/index.dart';
import '../../widgets/index.dart';

/// Here lays all available options for the user to configurate.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  static const route = '/settings';

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: context.translate('app.menu.settings'),
      body: ListView(
        children: <Widget>[
          HeaderText(
            context.translate('settings.headers.general'),
            head: true,
          ),
          BlocConsumer<ThemeCubit, ThemeState>(
            listener: (context, state) => Navigator.of(context).pop(),
            builder: (context, state) => ListCell.icon(
              icon: Icons.palette,
              title: context.translate('settings.theme.title'),
              subtitle: context.translate('settings.theme.body'),
              onTap: () => showBottomRoundDialog(
                context: context,
                title: context.translate('settings.theme.title'),
                padding: EdgeInsets.zero,
                children: <Widget>[
                  RadioCell<ThemeState>(
                    title: context.translate('settings.theme.theme.dark'),
                    groupValue: state,
                    value: ThemeState.dark,
                    onChanged: (value) => updateTheme(context, value),
                  ),
                  RadioCell<ThemeState>(
                    title: context.translate('settings.theme.theme.black'),
                    groupValue: state,
                    value: ThemeState.black,
                    onChanged: (value) => updateTheme(context, value),
                  ),
                  RadioCell<ThemeState>(
                    title: context.translate('settings.theme.theme.light'),
                    groupValue: state,
                    value: ThemeState.light,
                    onChanged: (value) => updateTheme(context, value),
                  ),
                  RadioCell<ThemeState>(
                    title: context.translate('settings.theme.theme.system'),
                    groupValue: state,
                    value: ThemeState.system,
                    onChanged: (value) => updateTheme(context, value),
                  ),
                ],
              ),
            ),
          ),
          Separator.divider(indent: 72),
          BlocConsumer<ImageQualityCubit, ImageQuality>(
            listener: (context, state) => Navigator.of(context).pop(),
            builder: (context, state) => ListCell.icon(
              icon: Icons.photo_filter,
              title: context.translate('settings.image_quality.title'),
              subtitle: context.translate('settings.image_quality.body'),
              onTap: () => showBottomRoundDialog(
                context: context,
                title: context.translate('settings.image_quality.title'),
                padding: EdgeInsets.zero,
                children: <Widget>[
                  RadioCell<ImageQuality>(
                    title:
                        context.translate('settings.image_quality.quality.low'),
                    groupValue: state,
                    value: ImageQuality.low,
                    onChanged: (value) => updateImageQuality(context, value),
                  ),
                  RadioCell<ImageQuality>(
                    title: context
                        .translate('settings.image_quality.quality.medium'),
                    groupValue: state,
                    value: ImageQuality.medium,
                    onChanged: (value) => updateImageQuality(context, value),
                  ),
                  RadioCell<ImageQuality>(
                    title: context
                        .translate('settings.image_quality.quality.high'),
                    groupValue: state,
                    value: ImageQuality.high,
                    onChanged: (value) => updateImageQuality(context, value),
                  ),
                ],
              ),
            ),
          ),
          Separator.divider(indent: 72),
          BlocConsumer<BrowserCubit, BrowserType>(
            listener: (context, state) => Navigator.of(context).pop(),
            builder: (context, state) => ListCell.icon(
              icon: Icons.language,
              title: context.translate('settings.internal_browser.title'),
              subtitle: context.translate(
                state == BrowserType.inApp
                    ? 'settings.internal_browser.internal_browser'
                    : 'settings.internal_browser.external_browser',
              ),
              onTap: () => showBottomRoundDialog(
                context: context,
                title: context.translate(
                  'settings.internal_browser.title',
                ),
                padding: EdgeInsets.zero,
                children: <Widget>[
                  RadioCell<BrowserType>(
                    title: context.translate(
                      'settings.internal_browser.internal_browser',
                    ),
                    groupValue: state,
                    value: BrowserType.inApp,
                    onChanged: (value) => updateBrowserType(context, value),
                  ),
                  RadioCell<BrowserType>(
                    title: context.translate(
                      'settings.internal_browser.external_browser',
                    ),
                    groupValue: state,
                    value: BrowserType.system,
                    onChanged: (value) => updateBrowserType(context, value),
                  ),
                ],
              ),
            ),
          ),
          HeaderText(context.translate('settings.headers.services')),
          ListCell.icon(
            icon: Icons.notifications,
            title: context.translate('settings.notifications.title'),
            subtitle: context.translate('settings.notifications.body'),
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
