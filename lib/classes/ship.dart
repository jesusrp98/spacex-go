import 'package:cherry/classes/vehicle.dart';

/// SHIP INFO CLASS
/// This class represents a real ship used in a SpaceX mission,
/// with all its details.
class Ship extends Vehicle {
  final List roles;
  final int weight;
  final int yearBuilt;
  final String homePort;
  final String status;
  final num speed;
  final List<double> coordinates;
  final int successfulLandings;
  final int attemptedLanding;

  Ship({
    id,
    name,
    type,
    active,
    height,
    diameter,
    reusable,
    description,
    url,
    this.roles,
    this.weight,
    this.yearBuilt,
    this.homePort,
    this.status,
    this.speed,
    this.coordinates,
    this.successfulLandings,
    this.attemptedLanding,
  }) : super(
          id: id,
          name: name,
          type: type,
          active: active,
          description: description,
          url: url,
        );

  factory Ship.fromJson(Map<String, dynamic> json) {
    return Ship(
      id: json['ship_id'],
      name: json['ship_name'],
      type: json['ship_type'],
      roles: json['roles'],
      active: json['active'],
      weight: json['weight_kg'],
      yearBuilt: json['year_built'],
      homePort: json['home_port'],
      status: json['status'],
      speed: json['speed_kn'],
      coordinates: [
        json['position']['latitude'],
        json['position']['longitude'],
      ],
      successfulLandings: json['successful_landings'],
      attemptedLanding: json['attempted_landings'],
    );
  }

  String get subtitle => 'Subtitle';
}
