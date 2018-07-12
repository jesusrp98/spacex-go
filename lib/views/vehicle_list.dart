import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'dart:async';
import 'dart:convert';

import '../classes/rocket_info.dart';
import '../classes/dragon_info.dart';
import '../classes/vehicle.dart';
import 'vehicle_cell.dart';

class VehicleList extends StatelessWidget {
  final String rocketUrl, dragonUrl;

  VehicleList({this.rocketUrl, this.dragonUrl});

  Future<List<RocketInfo>> fetchPost() async {
    List rocketJson =
        json.decode(await rootBundle.loadString('json/rockets.json'));
    List dragonJson =
        json.decode(await rootBundle.loadString('json/capsules.json'));

    return rocketJson.map((rocket) => RocketInfo.fromJson(rocket)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<RocketInfo>>(
        future: fetchPost(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              if (!snapshot.hasError) {
                final List<RocketInfo> vehicles = snapshot.data;
                ListView.builder(
                  key: PageStorageKey(rocketUrl),
                  padding: EdgeInsets.all(8.0),
                  itemCount: vehicles.length,
                  itemBuilder: (context, index) {
                    return VehicleCell(vehicles[index]);
                  },
                );
              } else
                return Text("Couldn't connect to server...");
          }
        },
      ),
    );
  }
}
