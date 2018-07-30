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
                subtitle: const Text('v0.1 - beta'),
                onTap: () => Scaffold
                    .of(context)
                    .showSnackBar(SnackBar(content: Text("It's a me!")))),
            const Divider(
              indent: 72.0,
              height: 12.0,
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Created by @jesusrp98'),
              subtitle: const Text('Reddit: /u/jesusrp98'),
              onTap: () async => await FlutterWebBrowser.openWebPage(
                  url: 'https://www.reddit.com/user/jesusrp98'),
            ),
            const Divider(
              indent: 72.0,
              height: 12.0,
            ),
            ListTile(
              leading: const Icon(Icons.star_border),
              title: const Text('Enjoying Project: Cherry?'),
              subtitle: const Text(
                  'Click here to leave your experience in the store'),
              onTap: () => Scaffold
                  .of(context)
                  .showSnackBar(SnackBar(content: Text('Hello Hello'))),
            ),
            const Divider(
              indent: 72.0,
              height: 12.0,
            ),
            ListTile(
              leading: const Icon(Icons.favorite_border),
              title: const Text('Support development'),
              subtitle: const Text(
                  'Click here to send some much needed help via PayPal'),
              onTap: () async => await FlutterWebBrowser.openWebPage(
                  url:
                      'https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=LRH6Z3L44WXLY'),
            ),
            const Divider(
              indent: 72.0,
              height: 12.0,
            ),
            ListTile(
              leading: const Icon(Icons.people_outline),
              title: const Text('This is free software'),
              subtitle: const Text(
                  'Source code is available in GitHub\nSupport free software for a better world :)'),
              onTap: () async => await FlutterWebBrowser.openWebPage(
                  url: 'https://github.com/jesusrp98/cherry'),
            ),
            const Divider(
              indent: 72.0,
              height: 12.0,
            ),
            ListTile(
              leading: const Icon(Icons.folder_open),
              title: const Text('App & credits'),
              subtitle: const Text(
                  'Created in 2018 by Chechu\nUsing SpaceX open-source API'),
              onTap: () async => await FlutterWebBrowser.openWebPage(
                  url: 'https://github.com/r-spacex/SpaceX-API'),
            ),
            const Divider(
              indent: 72.0,
              height: 12.0,
            ),
          ],
        )));
  }
}
