import 'package:cherry/url.dart';
import 'package:cherry/views/about_page.dart';
import 'package:cherry/views/launch_list.dart';
import 'package:cherry/views/roadster_page.dart';
import 'package:cherry/views/vehicle_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<StatelessWidget> _homeLists = List(_tabs.length);

  static const List<String> _popupItems = const <String>[
    'Roadster tracker',
    'About',
  ];

  static const List<Tab> _tabs = const <Tab>[
    const Tab(text: 'VEHICLES'),
    const Tab(text: 'UPCOMING'),
    const Tab(text: 'LATEST'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
      initialIndex: 1,
    );
    updateLists();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void updateLists() {
    _homeLists = [
      VehicleList(),
      LaunchList(Url.upcomingList),
      LaunchList(Url.launchesList),
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
            onSelected: (String option) {
              Navigator.of(context).push(
                PageRouteBuilder<Null>(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: const Interval(
                            0.0,
                            0.75,
                            curve: Curves.fastOutSlowIn,
                          ).transform(animation.value),
                          child: _popupItems.indexOf(option) == 0
                              ? RoadsterPage()
                              : AboutPage(),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          labelStyle: TextStyle(
            fontFamily: 'ProductSans',
            fontWeight: FontWeight.bold,
          ),
          controller: _tabController,
          tabs: _tabs,
        ),
      ),
      body: TabBarView(controller: _tabController, children: _homeLists),
      floatingActionButton: FloatingActionButton(
        onPressed: () => null,
        tooltip: 'Search',
        child: const Icon(Icons.search),
      ),
    );
  }
}
