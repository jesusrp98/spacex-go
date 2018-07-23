import 'package:cherry/classes/rocket_info.dart';
import 'package:cherry/views/hero_image.dart';
import 'package:cherry/views/list_cell.dart';
import 'package:cherry/views/rocket_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

class VehicleList extends StatelessWidget {
  final String rocketUrl, dragonUrl;

  VehicleList({this.rocketUrl, this.dragonUrl});

  Future fetchVehicles(BuildContext context) async {
    final rocketResponse = await http.get(rocketUrl);

    List rocketJson = json.decode(rocketResponse.body);
    return rocketJson.map((rocket) => RocketInfo.fromJson(rocket)).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (PageStorage
            .of(context)
            .readState(context, identifier: ValueKey(rocketUrl)) ==
        null)
      PageStorage.of(context).writeState(context, fetchVehicles(context),
          identifier: ValueKey(rocketUrl));

    return Center(
      child: FutureBuilder(
        future: PageStorage
            .of(context)
            .readState(context, identifier: ValueKey(rocketUrl)),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              if (!snapshot.hasError) {
                final List vehicles = snapshot.data;
                return ListView.builder(
                  key: PageStorageKey(rocketUrl),
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  itemCount: vehicles.length,
                  itemBuilder: (context, index) {
                    final RocketInfo vehicle = vehicles[index];
                    return ListCell(
                      image: HeroImage(
                        size: 82.0,
                        url:
                            'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/falcon9.jpg?alt=media&token=96b5c764-a2ea-43f0-8766-1761db1749d4',
                        tag: vehicle.name,
                      ),
                      title: vehicle.name,
                      subtitle: vehicle.getLaunchTime,
                      lateralWidget: VehicleState(vehicle.isActive),
                      onClick: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  RocketPage(vehicle))),
                    );
                  },
                );
              } else
                return const Text("Couldn't connect to server...");
          }
        },
      ),
    );
  }
}

class VehicleSection extends StatelessWidget {
  final String title;

  VehicleSection(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8.0,
            ),
            Divider(
              height: 0.0,
            )
          ],
        ));
  }
}
