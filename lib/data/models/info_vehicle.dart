import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

import '../../util/url.dart';
import '../classes/abstract/query_model.dart';
import 'index.dart';

/// Model which storages information from all kind of vehicles.
class VehiclesModel extends QueryModel {
  @override
  Future loadData([BuildContext context]) async {
    if (await canLoadData()) {
      // Fetch & add items
      final List capsules = await fetchData(Url.capsuleList);
      final List rockets = await fetchData(Url.rocketList);
      final List ships = await fetchData(Url.shipsList);

      items.add(RoadsterInfo.fromJson(await fetchData(Url.roadsterPage)));
      items.addAll(
        capsules.map((capsule) => CapsuleInfo.fromJson(capsule)).toList(),
      );
      items.addAll(
        rockets.map((rocket) => RocketInfo.fromJson(rocket)).toList(),
      );
      items.addAll(ships.map((ship) => ShipInfo.fromJson(ship)).toList());

      // Add one photo per vehicle & shuffle them
      if (photos.isEmpty) {
        final indices = List<int>.generate(7, (index) => index)
          ..shuffle()
          ..sublist(0, 5);

        for (final index in indices) {
          photos.add(getItem(index).getRandomPhoto);
        }
        photos.shuffle();
      }
      finishLoading();
    }
  }
}

/// VEHICLE MODEL
/// Details about a specific SpaceX vehicle.
/// Vehicles are considered Roadster, Dragons & Falcons, and ships.
abstract class Vehicle {
  final String id, name, type, description, url;
  final num height, diameter, mass;
  final bool active;
  final DateTime firstFlight;
  final List photos;

  const Vehicle({
    this.id,
    this.name,
    this.type,
    this.description,
    this.url,
    this.height,
    this.diameter,
    this.mass,
    this.active,
    this.firstFlight,
    this.photos,
  });

  String subtitle(BuildContext context);

  String getPhoto(int index) => photos[index];

  String get getProfilePhoto => getPhoto(0);

  int get getPhotosCount => photos.length;

  String get getRandomPhoto => photos[Random().nextInt(getPhotosCount)];

  String get getHeight => '${NumberFormat.decimalPattern().format(height)} m';

  String get getDiameter =>
      '${NumberFormat.decimalPattern().format(diameter)} m';

  String getMass(BuildContext context) => mass == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : '${NumberFormat.decimalPattern().format(mass)} kg';

  String get getFirstFlight => DateFormat.yMMMM().format(firstFlight);

  String get getFullFirstFlight => DateTime.now().isAfter(firstFlight)
      ? DateFormat.yMMMMd().format(firstFlight)
      : getFirstFlight;

  String firstLaunched(BuildContext context) => FlutterI18n.translate(
        context,
        DateTime.now().isAfter(firstFlight)
            ? 'spacex.vehicle.subtitle.first_launched'
            : 'spacex.vehicle.subtitle.scheduled_launch',
        {'date': getFirstFlight},
      );

  String get year => firstFlight.year.toString();
}
