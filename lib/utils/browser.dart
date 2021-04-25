import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubits/index.dart';

extension OpenURL on BuildContext {
  Future<dynamic> openUrl(String url) {
    if (read<BrowserCubit>().browserType == BrowserType.inApp) {
      return FlutterWebBrowser.openWebPage(
        url: url,
        customTabsOptions: CustomTabsOptions(
          instantAppsEnabled: true,
          showTitle: true,
        ),
      );
    } else {
      return canLaunch(url)
          .then((_) => launch(url))
          // ignore: return_of_invalid_type_from_catch_error
          .catchError((error) => error);
    }
  }
}
