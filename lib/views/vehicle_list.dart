import 'package:cherry/url.dart';
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

/// VEHICLE LIST CLASS
/// Displays a list made out of vehicles: capsules & rockets,
/// downloading them using urls.
/// Uses a ListCell item for each vehicle.
class VehicleList extends StatelessWidget {
  static final String _rocketUrl = Url.rocketList;
  static final String _capsuleUrl = Url.capsuleList;

  /// Downloads the list of launches
  Future fetchVehicles(BuildContext context) async {
    final rocketResponse = await http.get(_rocketUrl);
    final capsuleResponse = await http.get(_capsuleUrl);
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
    // Checks if list is cached
    if (PageStorage
            .of(context)
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
                      // Final vars used to display a vehicle
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

                      // Displays the vehicle with a ListCell item
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
