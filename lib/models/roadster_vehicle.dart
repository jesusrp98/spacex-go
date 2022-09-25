import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../utils/index.dart';
import 'index.dart';

/// Details about Elon Musk's Tesla Roadster launched on top of a Falcon Heavy
/// at February 6, 2018. Currently orbiting the Sun, between Earth & Mars.
class RoadsterVehicle extends Vehicle {
  final String orbit;
  final String video;
  final num apoapsis;
  final num periapsis;
  final num inclination;
  final num longitude;
  final num period;
  final num speed;
  final num earthDistance;
  final num marsDistance;

  const RoadsterVehicle({
    required String id,
    required String description,
    required String url,
    required num mass,
    required DateTime firstFlight,
    required List<String> photos,
    required this.orbit,
    required this.video,
    required this.apoapsis,
    required this.periapsis,
    required this.inclination,
    required this.longitude,
    required this.period,
    required this.speed,
    required this.earthDistance,
    required this.marsDistance,
  }) : super(
          id: id,
          name: 'Tesla Roadster',
          type: 'roadster',
          description: description,
          url: url,
          mass: mass,
          firstFlight: firstFlight,
          photos: photos,
        );

  factory RoadsterVehicle.fromJson(Map<String, dynamic> json) {
    return RoadsterVehicle(
      id: json['id'],
      description: json['details'],
      url: json['wikipedia'],
      mass: json['launch_mass_kg'],
      firstFlight: DateTime.parse(json['launch_date_utc']),
      photos: json['flickr_images'].cast<String>(),
      orbit: json['orbit_type'],
      video: json['video'],
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

  @override
  String subtitle(BuildContext context) => getFullLaunchDate(context);

  String getFullLaunchDate(BuildContext context) => context.translate(
        'spacex.vehicle.subtitle.launched',
        parameters: {'date': getLaunchDate(context)},
      );

  String getLaunchDate(BuildContext context) =>
      DateFormat.yMMMMd().format(firstFlight);

  String get getOrbit => toBeginningOfSentenceCase(orbit)!;

  String get getApoapsis =>
      '${NumberFormat.decimalPattern().format(apoapsis)} ua';

  String get getPeriapsis =>
      '${NumberFormat.decimalPattern().format(periapsis)} ua';

  String get getInclination =>
      '${NumberFormat.decimalPattern().format(inclination)}°';

  String get getLongitude =>
      '${NumberFormat.decimalPattern().format(longitude)}°';

  String getPeriod(BuildContext context) => context.translate(
        'spacex.vehicle.roadster.orbit.days',
        parameters: {
          'days': NumberFormat.decimalPattern().format(period.round())
        },
      );

  String get getSpeed =>
      '${NumberFormat.decimalPattern().format(speed.round())} km/h';

  String get getEarthDistance =>
      '${NumberFormat.decimalPattern().format(earthDistance.round())} km';

  String get getMarsDistance =>
      '${NumberFormat.decimalPattern().format(marsDistance.round())} km';

  @override
  List<Object?> get props => [
        id,
        description,
        url,
        mass,
        firstFlight,
        photos,
        orbit,
        video,
        apoapsis,
        periapsis,
        inclination,
        longitude,
        period,
        speed,
        earthDistance,
        marsDistance,
      ];
}
