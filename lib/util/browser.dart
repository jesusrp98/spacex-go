import 'package:flutter_web_browser/flutter_web_browser.dart';

Future<void> showUrl(String url) {
  return FlutterWebBrowser.openWebPage(
    url: url,
    customTabsOptions: CustomTabsOptions(
      instantAppsEnabled: true,
      showTitle: true,
    ),
  );
}
