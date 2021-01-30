import 'package:flutter_web_browser/flutter_web_browser.dart';

Future<void> openUrl(String url) {
  return FlutterWebBrowser.openWebPage(
    url: url,
    customTabsOptions: CustomTabsOptions(
      instantAppsEnabled: true,
      showTitle: true,
    ),
  );
}
