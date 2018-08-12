import 'package:cherry/url.dart';
import 'package:cherry/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

/// ABOUT PAGE CLASS
/// This class represent the about page. It contains a list with useful
/// information about the app & its developer.
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: const Text('About')),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.star_border),
            onPressed: () async => await FlutterWebBrowser.openWebPage(
                url: Url.storePage, androidToolbarColor: primaryColor),
            tooltip: 'Review app',
          )
        ],
      ),
      body: Scrollbar(
        child: ListView(children: <Widget>[
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Project: Cherry - SpaceX Launch Tracker'),
            subtitle: const Text('v0.2.0 - alpha'),
          ),
          const Divider(indent: 72.0, height: 0.0),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Created by @jesusrp98'),
            subtitle: const Text('Reddit: /u/jesusrp98'),
            onTap: () async => await FlutterWebBrowser.openWebPage(
                url: Url.authorReddit, androidToolbarColor: primaryColor),
          ),
          const Divider(indent: 72.0, height: 0.0),
          ListTile(
            leading: const Icon(Icons.star_border),
            title: const Text('Enjoying the app?'),
            subtitle:
                const Text('Click here to leave your experience in the store'),
            onTap: () async => await FlutterWebBrowser.openWebPage(
                url: Url.storePage, androidToolbarColor: primaryColor),
          ),
          const Divider(indent: 72.0, height: 0.0),
          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: const Text('Support development'),
            subtitle: const Text(
                'Click here to send some much needed help via PayPal'),
            onTap: () async => await FlutterWebBrowser.openWebPage(
                url: Url.paypalPage, androidToolbarColor: primaryColor),
          ),
          const Divider(indent: 72.0, height: 0.0),
          ListTile(
            leading: const Icon(Icons.people_outline),
            title: const Text('This is free software'),
            subtitle:
                const Text('Source code is available in GitHub for everyone'),
            onTap: () async => await FlutterWebBrowser.openWebPage(
                url: Url.cherryGithub, androidToolbarColor: primaryColor),
          ),
          const Divider(indent: 72.0, height: 0.0),
          ListTile(
              leading: const Icon(Icons.public),
              title: const Text('No imperial units?'),
              subtitle: const Text(
                  "There is a thing called 'International System of Units'"),
              onTap: () async => await FlutterWebBrowser.openWebPage(
                  url: Url.internationalSystem,
                  androidToolbarColor: primaryColor)),
          const Divider(indent: 72.0, height: 0.0),
          ListTile(
            leading: const Icon(Icons.folder_open),
            title: const Text('App credits'),
            subtitle: const Text('Using Open Source SpaceX REST API by Reddit'),
            onTap: () async => await FlutterWebBrowser.openWebPage(
                url: Url.spacexGithub, androidToolbarColor: primaryColor),
          ),
          const Divider(indent: 72.0, height: 0.0)
        ]),
      ),
    );
  }
}
