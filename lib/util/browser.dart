import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubits/index.dart';

extension OpenURL on BuildContext {
  Future<dynamic> openUrl(String url) {
    if (watch<BrowserCubit>().browserType == BrowserType.inApp) {
      return FlutterWebBrowser.openWebPage(
        url: url,
        customTabsOptions: CustomTabsOptions(
          instantAppsEnabled: true,
          showTitle: true,
        ),
      );
    } else {
      // open the URL inside the system default web browser
      // You can use the [url_launcher] library, which is already implemented :)
      return canLaunch(url).then((value) => launch(url).then((value) => value).catchError((error) => error));

    }
  }
}
