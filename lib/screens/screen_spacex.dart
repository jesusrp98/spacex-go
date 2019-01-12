import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/info_vehicle.dart';
import '../models/launch.dart';
import '../models/querry_model.dart';
import '../models/spacex_company.dart';
import '../models/spacex_home.dart';
import 'tab_company.dart';
import 'tab_home.dart';
import 'tab_launches.dart';
import 'tab_vehicles.dart';

/// SPACEX MAIN SCREEN
/// This view holds all tabs & its models: home, vehicles, upcoming & latest launches, & company tabs.
class SpacexScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SpacexTabScreen();
}

class _SpacexTabScreen extends State<SpacexScreen> {
  int _currentIndex = 0;

  static final List<QuerryModel> modelTab = [
    SpacexHomeModel(),
    VehiclesModel(),
    LaunchesModel(0),
    LaunchesModel(1),
    SpacexCompanyModel(),
  ];

  final List<ScopedModel> _tabs = [
    ScopedModel<SpacexHomeModel>(
      model: modelTab[0],
      child: SpacexHomeTab(),
    ),
    ScopedModel<VehiclesModel>(
      model: modelTab[1],
      child: VehiclesTab(),
    ),
    ScopedModel<LaunchesModel>(
      model: modelTab[2],
      child: LaunchesTab(0),
    ),
    ScopedModel<LaunchesModel>(
      model: modelTab[3],
      child: LaunchesTab(1),
    ),
    ScopedModel<SpacexCompanyModel>(
      model: modelTab[4],
      child: SpacexCompanyTab(),
    ),
  ];

  @override
  initState() {
    super.initState();
    modelTab.forEach((model) => model.loadData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text(FlutterI18n.translate(
              context,
              'spacex.home.icon',
            )),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text(FlutterI18n.translate(
              context,
              'spacex.vehicle.icon',
            )),
            icon: Icon(FontAwesomeIcons.rocket),
          ),
          BottomNavigationBarItem(
            title: Text(FlutterI18n.translate(
              context,
              'spacex.upcoming.icon',
            )),
            icon: Icon(Icons.access_time),
          ),
          BottomNavigationBarItem(
            title: Text(FlutterI18n.translate(
              context,
              'spacex.latest.icon',
            )),
            icon: Icon(Icons.library_books),
          ),
          BottomNavigationBarItem(
            title: Text(FlutterI18n.translate(
              context,
              'spacex.company.icon',
            )),
            icon: Icon(Icons.location_city),
          ),
        ],
      ),
    );
  }
}
