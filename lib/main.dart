import 'package:flutter/material.dart';
import 'package:cherry/views/launch_list.dart';

import 'dart:async';

void main() => runApp(new CherryApp());

class CherryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project: Cherry',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'RobotoMono',
      ),
      home: HomePage(title: 'Project: Cherry'),
    );
  }
}

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Future<Null> refreshLists() {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: new TabBar(
          controller: tabController,
          tabs: <Widget>[
            new Tab(
              text: 'UPCOMING',
            ),
            new Tab(
              text: 'LATEST',
            )
          ],
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          LaunchList('https://api.spacexdata.com/v2/launches/upcoming'),
          LaunchList('https://api.spacexdata.com/v2/launches?order=desc'),
        ],
        controller: tabController,
      ),
    );
  }
}
