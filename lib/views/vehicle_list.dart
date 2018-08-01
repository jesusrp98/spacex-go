import 'package:cherry/classes/rocket_info.dart';
import 'package:cherry/widgets/hero_image.dart';
import 'package:cherry/widgets/list_cell.dart';
import 'package:cherry/views/rocket_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

class VehicleList extends StatelessWidget {
  final String rocketUrl;

  VehicleList(this.rocketUrl);

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
                return Scrollbar(
                  child: ListView.builder(
                    key: PageStorageKey(rocketUrl),
                    itemCount: vehicles.length,
                    itemBuilder: (context, index) {
                      final RocketInfo vehicle = vehicles[index];
                      final VoidCallback onClick = () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => RocketPage(vehicle)));
                      return Column(
                        children: <Widget>[
                          ListCell(
                            image: HeroImage().buildHero(
                                context: context,
                                url: vehicle.getImageUrl,
                                tag: vehicle.id,
                                title: vehicle.name,
                                onClick: onClick),
                            title: vehicle.name,
                            subtitle: vehicle.getLaunchTime,
                            lateralWidget: VehicleState(vehicle.isActive),
                            onClick: () => onClick,
                          ),
                          const Divider(
                            height: 0.0,
                            indent: 104.0,
                            // color: dividerColor,
                          )
                        ],
                      );
                    },
                  ),
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
