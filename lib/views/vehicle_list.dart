import 'package:cherry/classes/capsule_info.dart';
import 'package:cherry/classes/rocket_info.dart';
import 'package:cherry/classes/vehicle.dart';
import 'package:cherry/views/capsule_page.dart';
import 'package:cherry/widgets/hero_image.dart';
import 'package:cherry/widgets/list_cell.dart';
import 'package:cherry/views/rocket_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

class VehicleList extends StatelessWidget {
  final String rocketUrl;
  final String capsuleUrl;

  VehicleList({this.rocketUrl, this.capsuleUrl});

  Future fetchVehicles(BuildContext context) async {
    final rocketResponse = await http.get(rocketUrl);
    final capsuleResponse = await http.get(capsuleUrl);
    List vehicleList = List();

    List rocketJson = json.decode(rocketResponse.body);
    List capsuleJson = json.decode(capsuleResponse.body);

    vehicleList.addAll(
        capsuleJson.map((capsule) => CapsuleInfo.fromJson(capsule)).toList());
    vehicleList.addAll(
        rocketJson.map((rocket) => RocketInfo.fromJson(rocket)).toList());

    return vehicleList;
  }

  @override
  Widget build(BuildContext context) {
    if (PageStorage
            .of(context)
            .readState(context, identifier: ValueKey(rocketUrl)) ==
        null)
      PageStorage.of(context).writeState(
            context,
            fetchVehicles(context),
            identifier: ValueKey(rocketUrl),
          );

    return Center(
      child: FutureBuilder(
        future: PageStorage.of(context).readState(
              context,
              identifier: ValueKey(rocketUrl),
            ),
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
                      final Vehicle vehicle = vehicles[index];
                      final VoidCallback onClick = () {
                        Navigator.of(context).push(
                          PageRouteBuilder<Null>(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return AnimatedBuilder(
                                animation: animation,
                                builder: (context, child) {
                                  return Opacity(
                                    opacity: const Interval(0.0, 0.75,
                                            curve: Curves.fastOutSlowIn)
                                        .transform(animation.value),
                                    child: (vehicle.type == 'rocket')
                                        ? RocketPage(vehicle)
                                        : CapsulePage(vehicle),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      };

                      return Column(children: <Widget>[
                        ListCell(
                          leading: HeroImage().buildHero(
                            context: context,
                            url: vehicle.getImageUrl,
                            tag: vehicle.id,
                            title: vehicle.name,
                            onClick: onClick,
                          ),
                          title: vehicle.name,
                          subtitle: vehicle.subtitle,
                          trailing: VehicleStatus(vehicle.active),
                          onTap: onClick,
                        ),
                        const Divider(height: 0.0, indent: 104.0)
                      ]);
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
