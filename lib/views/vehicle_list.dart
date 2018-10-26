import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../classes/capsule_info.dart';
import '../classes/roadster.dart';
import '../classes/rocket_info.dart';
import '../classes/ship_info.dart';
import '../classes/vehicle.dart';
import '../url.dart';
import '../widgets/hero_image.dart';
import '../widgets/list_cell.dart';
import 'capsule_page.dart';
import 'roadster_page.dart';
import 'rocket_page.dart';
import 'ship_page.dart';

/// VEHICLE LIST CLASS
/// Displays a list made out of vehicles: capsules & rockets,
/// downloading them using urls.
/// Uses a ListCell item for each vehicle.
class VehicleList extends StatelessWidget {
  static final String _rocketUrl = Url.rocketList;

  /// Downloads the list of launches
  Future fetchVehicles(BuildContext context) async {
    final rocketsResponse = await http.get(_rocketUrl);
    final capsulesResponse = await http.get(Url.capsuleList);
    final roadsterResponse = await http.get(Url.roadsterPage);
    final shipsResponse = await http.get(Url.shipsList);

    List vehicleList = List();

    List rocketsJson = json.decode(rocketsResponse.body);
    List capsulesJson = json.decode(capsulesResponse.body);
    List shipsJson = json.decode(shipsResponse.body);

    vehicleList.add(Roadster.fromJson(json.decode(roadsterResponse.body)));
    vehicleList.addAll(
        capsulesJson.map((capsule) => CapsuleInfo.fromJson(capsule)).toList());
    vehicleList.addAll(
        rocketsJson.map((rocket) => RocketInfo.fromJson(rocket)).toList());
    vehicleList
        .addAll(shipsJson.map((rocket) => ShipInfo.fromJson(rocket)).toList());

    return vehicleList;
  }

  @override
  Widget build(BuildContext context) {
    // Checks if list is cached
    if (PageStorage.of(context)
            .readState(context, identifier: ValueKey(_rocketUrl)) ==
        null)
      PageStorage.of(context).writeState(
        context,
        fetchVehicles(context),
        identifier: ValueKey(_rocketUrl),
      );

    return Center(
      child: FutureBuilder(
        future: PageStorage.of(context).readState(
          context,
          identifier: ValueKey(_rocketUrl),
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
                    key: PageStorageKey(_rocketUrl),
                    itemCount: vehicles.length,
                    itemBuilder: (context, index) {
                      final Vehicle vehicle = vehicles[index];

                      return Column(children: <Widget>[
                        ListCell(
                          leading: HeroImage().buildHero(
                            context: context,
                            size: HeroImage.smallSize,
                            url: vehicle.getImageUrl,
                            tag: vehicle.id,
                            title: vehicle.name,
                          ),
                          title: vehicle.name,
                          subtitle: vehicle.subtitle,
                          trailing: VehicleStatus(vehicle.active),
                          onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      (vehicle.type == 'rocket')
                                          ? RocketPage(vehicle)
                                          : (vehicle.type == 'capsule')
                                              ? CapsulePage(vehicle)
                                              : (vehicle.type == 'ship')
                                                  ? ShipPage(vehicle)
                                                  : RoadsterPage(vehicle),
                                ),
                              ),
                        ),
                        const Divider(height: 0.0, indent: 96.0)
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
