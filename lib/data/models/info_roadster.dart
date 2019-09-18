import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

import '../../util/url.dart';
import 'index.dart';

/// Details about Elon Musk's Tesla Roadster launched on top of a Falcon Heavy
/// at February 6, 2018. Currently orbiting the Sun, between Earth & Mars.
class RoadsterInfo extends Vehicle {
  final String orbit, video;
  final num apoapsis,
      periapsis,
      inclination,
      longitude,
      period,
      speed,
      earthDistance,
      marsDistance;

  const RoadsterInfo({
    description,
    url,
    mass,
    firstFlight,
    photos,
    this.orbit,
    this.video,
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
          description: description,
          url: url,
          mass: mass,
          firstFlight: firstFlight,
          photos: photos,
        );

  factory RoadsterInfo.fromJson(Map<String, dynamic> json) {
    return RoadsterInfo(
      description: json['details'],
      url: json['wikipedia'],
      mass: json['launch_mass_kg'],
      firstFlight: DateTime.parse(json['launch_date_utc']).toLocal(),
      photos: json['flickr_images'],
      orbit: json['orbit_type'],
      video: Url.roadsterVideo,
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

  String getFullLaunchDate(BuildContext context) => FlutterI18n.translate(
        context,
        'spacex.vehicle.subtitle.launched',
        {'date': DateFormat.yMMMMd().format(firstFlight)},
      );

  String getLaunchDate(BuildContext context) =>
      DateFormat.yMMMMd().format(firstFlight);

  String get getOrbit => '${orbit[0].toUpperCase()}${orbit.substring(1)}';

  String get getApoapsis =>
      '${NumberFormat.decimalPattern().format(apoapsis)} ua';

  String get getPeriapsis =>
      '${NumberFormat.decimalPattern().format(periapsis)} ua';

  String get getInclination =>
      '${NumberFormat.decimalPattern().format(inclination)}°';

  String get getLongitude =>
      '${NumberFormat.decimalPattern().format(longitude)}°';

  String getPeriod(BuildContext context) => FlutterI18n.translate(
        context,
        'spacex.vehicle.roadster.orbit.days',
        {'days': NumberFormat.decimalPattern().format(period.round())},
      );

  String get getSpeed =>
      '${NumberFormat.decimalPattern().format(speed.round())} km/h';

  String get getEarthDistance =>
      '${NumberFormat.decimalPattern().format(earthDistance.round())} km';

  String get getMarsDistance =>
      '${NumberFormat.decimalPattern().format(marsDistance.round())} km';
}
