import 'package:cherry/classes/vehicle.dart';
import 'package:intl/intl.dart';

/// ROADSTER CLASS
/// This class contains all information available from Elon Musk's Tesla
/// Roadster, sent to space in the Falcon Heavy Test Flight.
class Roadster extends Vehicle {
  final String orbit;
  final num apoapsis, periapsis, inclination, longitude, period, speed, earthDistance, marsDistance;

  Roadster({
    details,
    url,
    mass,
    firstFlight,
    this.orbit,
    this.apoapsis,
    this.periapsis,
    this.inclination,
    this.longitude,
    this.period,
    this.speed,
    this.earthDistance,
    this.marsDistance,
  }) : super(
          id: 'roadster',
          name: 'Tesla Roadster',
          type: 'roadster',
          details: details,
          url: url,
          height: 1.127,
          diameter: 1.873,
          mass: mass,
          active: true,
          firstFlight: firstFlight,
        );

  factory Roadster.fromJson(Map<String, dynamic> json) {
    return Roadster(
      details: json['details'],
      url: json['wikipedia'],
      mass: json['launch_mass_kg'],
      firstFlight: DateTime.parse(json['launch_date_utc']).toLocal(),
      orbit: json['orbit_type'],
      apoapsis: json['apoapsis_au'],
      periapsis: json['periapsis_au'],
      inclination: json['inclination'],
      longitude: json['longitude'],
      period: json['period_days'],
      speed: json['speed_kph'],
      earthDistance: json['earth_distance_km'],
      marsDistance: json['mars_distance_km'],
    );
  }

  String get subtitle => "Elon Musk's car";

  String get getDate =>
      DateFormat.yMMMMd().addPattern('Hm', '  ·  ').format(firstFlight);

  String get getOrbit => '${orbit[0].toUpperCase()}${orbit.substring(1)}';

  String get getApoapsis =>
      '${NumberFormat.decimalPattern().format(apoapsis)} ua';

  String get getPeriapsis =>
      '${NumberFormat.decimalPattern().format(periapsis)} ua';

  String get getInclination =>
      '${NumberFormat.decimalPattern().format(inclination)}°';

  String get getLongitude =>
      '${NumberFormat.decimalPattern().format(longitude)}°';

  String get getPeriod =>
      '${NumberFormat.decimalPattern().format(period.round())} days';

  String get getSpeed =>
      '${NumberFormat.decimalPattern().format(speed.round())} km/h';

  String get getEarthDistance =>
      '${NumberFormat.decimalPattern().format(earthDistance.round())} km';

  String get getMarsDistance =>
      '${NumberFormat.decimalPattern().format(marsDistance.round())} km';
}
