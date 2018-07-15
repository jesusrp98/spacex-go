import 'package:flutter/material.dart';

import 'package:cherry/views/launch_list.dart';
import 'package:cherry/views/vehicle_list.dart';

void main() => runApp(new CherryApp());

class CherryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project: Cherry',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'ProductSans',
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  List<StatelessWidget> homeLists = List(3);

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    updateLists();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void updateLists() {
    homeLists[0] = VehicleList(
      rocketUrl: 'https://api.spacexdata.com/v2/rockets/',
      dragonUrl: 'https://api.spacexdata.com/v2/capsules/',
    );
    homeLists[1] =
        LaunchList('https://api.spacexdata.com/v2/launches/upcoming');
    homeLists[2] =
        LaunchList('https://api.spacexdata.com/v2/launches?order=desc');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Project: Cherry',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: tabController,
          tabs: <Widget>[
            Tab(text: 'VEHICLES'),
            Tab(text: 'UPCOMING'),
            Tab(text: 'LATEST'),
          ],
        ),
      ),
      body: TabBarView(controller: tabController, children: homeLists),
    );
  }
}
