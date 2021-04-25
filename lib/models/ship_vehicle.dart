import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../utils/index.dart';
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
    );
  }

  @override
  String subtitle(BuildContext context) => context.translate(
        'spacex.vehicle.subtitle.ship_built',
        parameters: {'date': firstFlight.year.toString()},
      );

  String getModel(BuildContext context) =>
      model ?? context.translate('spacex.other.unknown');

  bool get hasSeveralRoles => roles.length > 1;

  String get primaryRole => roles[0];

  String get secondaryRole => roles[1];

  bool get hasMissions => missions.isNotEmpty;

  String getStatus(BuildContext context) => status?.isNotEmpty == true
      ? status
      : context.translate('spacex.other.unknown');

  String get getBuiltFullDate => year;

  String getSpeed(BuildContext context) => speed == null
      ? context.translate('spacex.other.unknown')
      : '${NumberFormat.decimalPattern().format(speed * 1.852)} km/h';

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
      ];
}
