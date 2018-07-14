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
  final PageStorageBucket bucket = PageStorageBucket();
  List<Widget> homeLists = List(3);
  Widget currentPage;
  int currentTab = 1;

  @override
  void initState() {
    super.initState();
    updateLists();
    currentPage = homeLists[1];
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
      ),
      body: PageStorage(bucket: bucket, child: currentPage),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentTab,
        onTap: (int index) {
          setState(() {
            currentTab = index;
            currentPage = homeLists[index];
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_car), title: Text('VEHICLES')),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm), title: Text('UPCOMING')),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), title: Text('LATEST')),
        ],
      ),
    );
  }
}
