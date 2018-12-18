import 'package:flutter/material.dart';

/// ABOUT PAGE CLASS
/// This class represent the about page. It contains a list with useful
/// information about the app & its developer.
class AboutScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('About'), centerTitle: true),
      body: Scrollbar(
        child: ListView(children: <Widget>[
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Space Curiosity'),
            subtitle: const Text('v0.0.1 - on development'),
          ),
          const Divider(indent: 72.0, height: 0.0),
        ]),
      ),
    );
  }
}
