import 'package:flutter/material.dart';
import 'package:cherry/views/launch_list.dart';

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
  TabController _tabController;

  List<StatelessWidget> launchesLists = List(2);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    updateLists();
  }

  @override
  void dispose() {
    _tabController.dispose();
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
    final _scaffoldKey = new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Project: Cherry',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: new TabBar(
          controller: _tabController,
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
      body: Center(
        child: TabBarView(
          controller: _tabController,
          //TODO can we do better here?
          children: <Widget>[launchesLists[0], launchesLists[1]],
        ),
      ),
    );
  }
}
