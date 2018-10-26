import 'package:intl/intl.dart';

import 'vehicle.dart';

/// SHIP INFO CLASS
/// This class represents a real ship used in a SpaceX mission,
/// with all its details.
class ShipInfo extends Vehicle {
  final String model, use, homePort, status;
  final List roles;
  final num speed;
  final List<double> coordinates;
  final int attemptedLandings, successfulLandings;

  ShipInfo({
    id,
    name,
    active,
    firstFlight,
    mass,
    description,
    url,
    photos,
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
          url: url,
          photos: photos,
        );

  factory ShipInfo.fromJson(Map<String, dynamic> json) {
    return ShipInfo(
      id: json['ship_id'],
      name: json['ship_name'],
      active: json['active'],
      firstFlight: DateTime(json['year_built']),
      photos: [json['image']],
      mass: json['weight_kg'],
      description: _getDescription(json['missions']),
      url: json['url'],
      model: json['ship_model'],
      use: json['ship_type'],
      roles: json['roles'],
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

  static String _getDescription(List missions) {
    String allMissions = '';
    if (missions.isEmpty)
      return 'This boat has not participated in any mission.';
    else {
      missions.forEach(
        (mission) => allMissions +=
            mission['name'] + ((mission != missions.last) ? ',  ' : '.'),
      );
      return allMissions;
    }
  }

  String get subtitle => 'Ship built in ${firstFlight.year}';

  bool get hasUrl => url != null;

  String get getModel => model ?? 'Unknown';

  bool get isLandable => attemptedLandings != null;

  bool get hasSeveralRoles => roles.length > 1;

  String get primaryRole => roles[0];

  String get secondaryRole => roles[1];

  String get getHomePort => 'Home at $homePort';

  String get getStatus => status ?? 'Unknown';

  String get getSpeed => speed == null
      ? 'Unknown'
      : '${NumberFormat.decimalPattern().format(speed * 1.852)} km/h';

  String get getCoordinates => coordinates.isNotEmpty
      ? 'Unknown'
      : (coordinates[0].toStringAsPrecision(5) +
          ',  ' +
          coordinates[1].toStringAsPrecision(5));

  String get getAttemptedLandings => attemptedLandings.toString();

  String get getSuccessfulLandings => successfulLandings.toString();
}
