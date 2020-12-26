import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

import 'index.dart';

/// General information about a ship used by SpaceX.
class ShipVehicle extends Vehicle {
  final String model;
  final String use;
  final String homePort;
  final String status;
  final List<String> roles;
  final List<LaunchDetails> missions;
  final num speed;
  final List<double> coordinates;

  const ShipVehicle({
    String id,
    String name,
    String url,
    num mass,
    bool active,
    DateTime firstFlight,
    List<String> photos,
    this.model,
    this.use,
    this.roles,
    this.missions,
    this.homePort,
    this.status,
    this.speed,
    this.coordinates,
  }) : super(
          id: id,
          name: name,
          type: 'ship',
          url: url,
          mass: mass,
          active: active,
          firstFlight: firstFlight,
          photos: photos,
        );

  factory ShipVehicle.fromJson(Map<String, dynamic> json) {
    return ShipVehicle(
      id: json['id'],
      name: json['name'],
      url: json['link'],
      mass: json['mass_kg'],
      active: json['active'],
      firstFlight: DateTime(json['year_built']),
      photos: [json['image']].cast<String>(),
      model: json['model'],
      use: json['type'],
      roles: json['roles'].cast<String>(),
      missions: [
        for (final item in json['launches']) LaunchDetails.fromJson(item)
      ],
      homePort: json['home_port'],
      status: json['status'],
      speed: json['speed_kn'],
      coordinates: [
        json['latitude'],
        json['longitude'],
      ],
    );
  }

  @override
  String subtitle(BuildContext context) => FlutterI18n.translate(
        context,
        'spacex.vehicle.subtitle.ship_built',
        translationParams: {'date': firstFlight.year.toString()},
      );

  String getModel(BuildContext context) =>
      model ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  bool get hasSeveralRoles => roles.length > 1;

  String get primaryRole => roles[0];

  String get secondaryRole => roles[1];

  bool get hasMissions => missions.isNotEmpty;

  String getStatus(BuildContext context) =>
      status ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String get getBuiltFullDate => year;

  String getSpeed(BuildContext context) => speed == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : '${NumberFormat.decimalPattern().format(speed * 1.852)} km/h';

  String getCoordinates(BuildContext context) => coordinates.isNotEmpty
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : '${coordinates[0].toStringAsPrecision(5)},  ${coordinates[1].toStringAsPrecision(5)}';

  @override
  List<Object> get props => [
        id,
        name,
        url,
        mass,
        active,
        firstFlight,
        photos,
        model,
        use,
        roles,
        missions,
        homePort,
        status,
        speed,
        coordinates,
      ];
}
