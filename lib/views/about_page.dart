import 'package:cherry/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('About'),
        ),
        body: Scrollbar(
            child: ListView(
          children: <Widget>[
            ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Project: Cherry - SpaceX Launch Tracker'),
                subtitle: const Text('v0.1.0 - beta')),
            const Divider(
              indent: 72.0,
              height: 0.0,
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Created by @jesusrp98'),
              subtitle: const Text('Reddit: /u/jesusrp98'),
              onTap: () async => await FlutterWebBrowser.openWebPage(
                  url: 'https://www.reddit.com/user/jesusrp98',
                  androidToolbarColor: primaryColor),
            ),
            const Divider(
              indent: 72.0,
              height: 0.0,
            ),
            ListTile(
              leading: const Icon(Icons.star_border),
              title: const Text('Enjoying Project: Cherry?'),
              subtitle: const Text(
                  'Click here to leave your experience in the store'),
              onTap: () async => await FlutterWebBrowser.openWebPage(
                  url:
                      'https://play.google.com/store/apps/details?id=com.chechu.hamilton',
                  androidToolbarColor: primaryColor),
            ),
            const Divider(
              indent: 72.0,
              height: 0.0,
            ),
            ListTile(
              leading: const Icon(Icons.favorite_border),
              title: const Text('Support development'),
              subtitle: const Text(
                  'Click here to send some much needed help via PayPal'),
              onTap: () async => await FlutterWebBrowser.openWebPage(
                  url:
                      'https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=LRH6Z3L44WXLY',
                  androidToolbarColor: primaryColor),
            ),
            const Divider(
              indent: 72.0,
              height: 0.0,
            ),
            ListTile(
              leading: const Icon(Icons.people_outline),
              title: const Text('This is free software'),
              subtitle: const Text('Source code is available in GitHub for everyone'),
              onTap: () async => await FlutterWebBrowser.openWebPage(
                  url: 'https://github.com/jesusrp98/cherry',
                  androidToolbarColor: primaryColor),
            ),
            const Divider(
              indent: 72.0,
              height: 0.0,
            ),
            ListTile(
              leading: const Icon(Icons.public),
              title: const Text('No imperial units?'),
              subtitle: const Text(
                  "There is a thing called 'International System of Units'"),
              onTap: () async => await FlutterWebBrowser.openWebPage(
                  url:
                      'https://en.wikipedia.org/wiki/International_System_of_Units',
                  androidToolbarColor: primaryColor),
            ),
            const Divider(
              indent: 72.0,
              height: 0.0,
            ),
            ListTile(
              leading: const Icon(Icons.folder_open),
              title: const Text('App credits'),
              subtitle: const Text('Using Open Source SpaceX REST API by Reddit'),
              onTap: () async => await FlutterWebBrowser.openWebPage(
                  url: 'https://github.com/r-spacex/SpaceX-API',
                  androidToolbarColor: primaryColor),
            ),
            const Divider(
              indent: 72.0,
              height: 0.0,
            ),
          ],
        )));
  }
}
