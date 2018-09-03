import 'package:cherry/url.dart';
import 'package:cherry/views/about_page.dart';
import 'package:cherry/views/launch_list.dart';
import 'package:cherry/views/vehicle_list.dart';
import 'package:flutter/material.dart';
import 'package:quick_actions/quick_actions.dart';

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
    int homePage;

    // Adding shortcuts
    final QuickActions quickActions = const QuickActions();
    quickActions.initialize((String shortcut) {
      if (shortcut == 'action_vehicle')
        homePage = 0;
      else if (shortcut == 'action_upcoming')
        homePage = 1;
      else if (shortcut == 'action_latest') homePage = 2;
    });
    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
        type: 'action_vehicle',
        localizedTitle: 'Vehicles',
        icon: 'AppIcon',
      ),
      const ShortcutItem(
        type: 'action_upcoming',
        localizedTitle: 'Upcoming',
        icon: 'AppIcon',
      ),
      const ShortcutItem(
        type: 'action_latest',
        localizedTitle: 'Latest launches',
        icon: 'AppIcon',
      ),
    ]);

    // Tab controller init
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
      initialIndex: homePage ?? 1,
    );

    // List array init
    _homeLists = [
      VehicleList(),
      LaunchList(Url.upcomingList),
      LaunchList(Url.launchesList),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SpaceX GO!',
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
