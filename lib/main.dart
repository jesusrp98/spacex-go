import 'package:cherry/views/about_page.dart';
import 'package:cherry/views/launch_list.dart';
import 'package:cherry/views/vehicle_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cherry/colors.dart';

void main() => runApp(new CherryApp());

class CherryApp extends StatelessWidget {
  ThemeData _buildThemeData() => ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'ProductSans',
      primaryColor: primaryColor,
      accentColor: accentColor,
      canvasColor: backgroundColor,
      cardColor: cardColor,
      highlightColor: highlightColor,
      textTheme: TextTheme().copyWith(
          title: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
          headline: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
          display1: TextStyle(fontSize: 24.0, color: lateralText),
          subhead: TextStyle(fontSize: 17.0, color: secondaryText),
          body1: TextStyle(fontSize: 15.0, color: secondaryText)));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Project: Cherry',
        theme: _buildThemeData(),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<StatelessWidget> _homeLists = List(_tabs.length);

  static const List<String> _popupItems = const <String>['About'];

  static const List<Tab> _tabs = const <Tab>[
    const Tab(text: 'ROCKETS'),
    const Tab(text: 'UPCOMING'),
    const Tab(text: 'LATEST'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: _tabs.length, vsync: this, initialIndex: 1);
    updateLists();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void updateLists() {
    _homeLists = [
      VehicleList('https://api.spacexdata.com/v2/rockets/'),
      LaunchList('https://api.spacexdata.com/v2/launches/upcoming'),
      LaunchList('https://api.spacexdata.com/v2/launches?order=desc')
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project: Cherry',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: <Widget>[
          PopupMenuButton<String>(
            itemBuilder: (context) {
              return _popupItems.map((f) {
                return PopupMenuItem(
                  value: f,
                  child: Text(f),
                );
              }).toList();
            },
            onSelected: (String option) => Navigator.push(
                context, CupertinoPageRoute(builder: (context) => AboutPage())),
          )
        ],
        bottom: TabBar(
          labelStyle: TextStyle(
              fontFamily: 'ProductSans',
              fontSize: 15.0,
              fontWeight: FontWeight.bold),
          labelColor: secondaryText,
          unselectedLabelColor: lateralText,
          controller: _tabController,
          tabs: _tabs,
        ),
      ),
      body: TabBarView(controller: _tabController, children: _homeLists),
    );
  }
}
