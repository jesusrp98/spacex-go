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

  List<StatelessWidget> launchesLists = List(2);

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    updateLists();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void updateLists() {
    launchesLists[0] =
        LaunchList('https://api.spacexdata.com/v2/launches/upcoming');
    launchesLists[1] =
        LaunchList('https://api.spacexdata.com/v2/launches?order=desc');
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
              text: 'COMPLETED',
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[launchesLists[0], launchesLists[1]],
      ),
    );
  }
}
