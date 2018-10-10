import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:get_version/get_version.dart';

import '../colors.dart';
import '../url.dart';

/// ABOUT PAGE CLASS
/// This class represent the about page. It contains a list with useful
/// information about the app & its developer.
class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String _projectVersion = '';

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    String projectVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectVersion = await GetVersion.projectVersion;
    } on PlatformException {
      projectVersion = 'Unknown';
    }

    setState(() => _projectVersion = projectVersion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About'), centerTitle: true),
      body: Scrollbar(
        child: ListView(children: <Widget>[
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('SpaceX GO! - Launch Tracker'),
            subtitle: Text('v$_projectVersion - public'),
          ),
          const Divider(indent: 72.0, height: 0.0),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Created by @jesusrp98'),
            subtitle: const Text('Reddit: u/jesusrp98'),
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
            leading: const Icon(Icons.mail_outline),
            title: const Text('Email me'),
            subtitle: const Text('Report a bug or request a feature'),
            onTap: () async => await FlutterWebBrowser.openWebPage(
                url: Url.email, androidToolbarColor: primaryColor),
          ),
          const Divider(indent: 72.0, height: 0.0),
          ListTile(
            leading: const Icon(Icons.apps),
            title: const Text('More from Chechu'),
            subtitle: const Text('Well designed, open-source apps'),
            onTap: () async => await FlutterWebBrowser.openWebPage(
                url: Url.authorStore, androidToolbarColor: primaryColor),
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
                  "Learn more about the 'International System of Units'"),
              onTap: () async => await FlutterWebBrowser.openWebPage(
                  url: Url.internationalSystem,
                  androidToolbarColor: primaryColor)),
          const Divider(indent: 72.0, height: 0.0),
          ListTile(
            leading: const Icon(Icons.folder_open),
            title: const Text('App credits'),
            subtitle: const Text(
                'Using open-source r/SpaceX REST API by @jakewmeyer'),
            onTap: () async => await FlutterWebBrowser.openWebPage(
                url: Url.spacexGithub, androidToolbarColor: primaryColor),
          ),
          const Divider(indent: 72.0, height: 0.0),
          const SizedBox(height: 16.0),
          Text(
            'This application is not affiliated in any way with SpaceX.\nSpaceX is a private trademark.',
            style: Theme.of(context).textTheme.body1.copyWith(
                  color: secondaryText,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
        ]),
      ),
    );
  }
}
