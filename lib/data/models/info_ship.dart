import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

import 'info_vehicle.dart';
import 'mission_item.dart';

/// General information about a ship used by SpaceX.
class ShipInfo extends Vehicle {
  final String model, use, homePort, status;
  final List roles, missions;
  final num speed;
  final List<double> coordinates;
  final int attemptedLandings,
      successfulLandings,
      attemptedCatches,
      successfulCatches;

  const ShipInfo({
    id,
    name,
    url,
    mass,
    active,
    firstFlight,
    photos,
    this.model,
    this.use,
    this.roles,
    this.missions,
    this.homePort,
    this.status,
    this.speed,
    this.coordinates,
    this.attemptedLandings,
    this.successfulLandings,
    this.attemptedCatches,
    this.successfulCatches,
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

  factory ShipInfo.fromJson(Map<String, dynamic> json) {
    return ShipInfo(
      id: json['ship_id'],
      name: json['ship_name'],
      url: json['url'],
      mass: json['weight_kg'],
      active: json['active'],
      firstFlight: DateTime(json['year_built']),
      photos: [json['image']],
      model: json['ship_model'],
      use: json['ship_type'],
      roles: json['roles'],
      missions: json['missions']
          .map((mission) => MissionItem.fromJson(mission))
          .toList(),
      homePort: json['home_port'],
      status: json['status'],
      speed: json['speed_kn'],
      coordinates: [
        json['position']['latitude'],
        json['position']['longitude'],
      ],
      attemptedLandings: json['attempted_landings'],
      successfulLandings: json['successful_landings'],
      attemptedCatches: json['attempted_catches'],
      successfulCatches: json['successful_catches'],
    );
  }

  @override
  String subtitle(BuildContext context) => FlutterI18n.translate(
        context,
        'spacex.vehicle.subtitle.ship_built',
        {'date': firstFlight.year.toString()},
      );

  String getModel(BuildContext context) =>
      model ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  bool get isLandable => attemptedLandings != null;

  bool get canCatch => attemptedCatches != null;

  bool get hasExtras => isLandable || canCatch;

  bool get hasSeveralRoles => roles.length > 1;

  String get primaryRole => roles[0];

  String get secondaryRole => roles[1];

  bool get hasMissions => missions.isNotEmpty;

  String getStatus(BuildContext context) =>
      status ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String get getBuiltFullDate => DateFormat.yMMMM().format(firstFlight);

  String getSpeed(BuildContext context) => speed == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : '${NumberFormat.decimalPattern().format(speed * 1.852)} km/h';

  String getCoordinates(BuildContext context) => coordinates.isNotEmpty
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : '${coordinates[0].toStringAsPrecision(5)},  ${coordinates[1].toStringAsPrecision(5)}';

  String get getSuccessfulLandings => '$successfulLandings/$attemptedLandings';

  String get getSuccessfulCatches => '$successfulCatches/$attemptedCatches';
}
