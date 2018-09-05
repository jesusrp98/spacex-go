import 'package:cherry/classes/vehicle.dart';
import 'package:intl/intl.dart';

/// SHIP INFO CLASS
/// This class represents a real ship used in a SpaceX mission,
/// with all its details.
class ShipInfo extends Vehicle {
  final String model;
  final String use;
  final List roles;
  final String homePort;
  final String status;
  final num speed;
  final List<double> coordinates;
  final int attemptedLandings;
  final int successfulLandings;

  ShipInfo({
    id,
    name,
    active,
    firstFlight,
    mass,
    description,
    this.model,
    this.use,
    this.roles,
    this.homePort,
    this.status,
    this.speed,
    this.coordinates,
    this.attemptedLandings,
    this.successfulLandings,
  }) : super(
          id: id,
          name: name,
          type: 'ship',
          active: active,
          firstFlight: firstFlight,
          mass: mass,
          description: description,
        );

  factory ShipInfo.fromJson(Map<String, dynamic> json) {
    return ShipInfo(
      id: json['ship_id'],
      name: json['ship_name'],
      active: json['active'],
      firstFlight: DateTime(json['year_built']),
      description: 'Description',
      model: json['ship_model'],
      use: json['ship_type'],
      roles: json['roles'],
      mass: json['weight_kg'],
      homePort: json['home_port'],
      status: json['status'],
      speed: json['speed_kn'],
      coordinates: [
        json['position']['latitude'],
        json['position']['longitude'],
      ],
      attemptedLandings: json['attempted_landings'],
      successfulLandings: json['successful_landings'],
    );
  }

  String get subtitle => 'Ship built in ${firstFlight.year}';

  bool get hasModel => model != null;

  bool get isLandable => attemptedLandings != null;

  bool get hasSeveralRoles => roles.length > 1;

  String get primaryRole => roles[0];

  String get secondaryRole => roles[1];

  bool get hasMass => mass != null;

  String get getHomePort => 'Home port at $homePort';

  bool get hasStatus => status != null;

  bool get hasSpeed => speed != null;

  String get getSpeed => '${NumberFormat.decimalPattern().format(speed)} kn';

  bool get hasCoordinates => coordinates.isEmpty;

  String get getCoordinates => (coordinates[0].toStringAsPrecision(5) +
      ',  ' +
      coordinates[1].toStringAsPrecision(5));

  String get getAttemptedLandings => attemptedLandings.toString();

  String get getSuccessfulLandings => successfulLandings.toString();
}
