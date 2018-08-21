import 'package:cherry/url.dart';
import 'package:cherry/views/about_page.dart';
import 'package:cherry/views/launch_list.dart';
import 'package:cherry/views/roadster_page.dart';
import 'package:cherry/views/vehicle_list.dart';
import 'package:flutter/material.dart';

/// HOME PAGE CLASS
/// Home page of the app.
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<StatelessWidget> _homeLists = List(_tabs.length);

  /// List of the TabBar's tabs
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
        title: const Text(
          'Project: Cherry',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
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
                          child: AboutPage(),
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
    );
  }
}
