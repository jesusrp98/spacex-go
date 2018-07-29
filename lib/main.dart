import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cherry/views/about_page.dart';
import 'package:cherry/views/launch_list.dart';
import 'package:cherry/views/vehicle_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cherry/colors.dart';

void main() => runApp(new CherryApp());

class CherryApp extends StatelessWidget {
  ThemeData buildThemeData() => ThemeData(
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
        theme: buildThemeData(),
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
  static List<String> popupItems = ['About'];
  TabController tabController;
  List<StatelessWidget> homeLists = List(3);

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    updateLists();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void updateLists() {
    homeLists = [
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
              return popupItems.map((f) {
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
          labelColor: Colors.black,
          unselectedLabelColor: secondaryText,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BubbleTabIndicator(
              indicatorHeight: 32.0,
              indicatorColor: accentColor,
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              insets: const EdgeInsets.symmetric(horizontal: 18.0)),
          controller: tabController,
          tabs: <Widget>[
            const Tab(text: 'ROCKETS'),
            const Tab(text: 'UPCOMING'),
            const Tab(text: 'LATEST')
          ],
        ),
      ),
      body: TabBarView(controller: tabController, children: homeLists),
    );
  }
}
