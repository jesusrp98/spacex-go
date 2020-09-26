import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

/// Details about a specific SpaceX vehicle.
/// Vehicles are considered Roadster, Dragons & Falcons, and ships.
abstract class Vehicle extends Equatable {
  final String id;
  final String name;
  final String type;
  final String description;
  final String url;
  final num height;
  final num diameter;
  final num mass;
  final bool active;
  final DateTime firstFlight;
  final List<String> photos;

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

  String get getRandomPhoto => photos[Random().nextInt(photos.length)];

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
        translationParams: {'date': getFirstFlight},
      );

  String get year => firstFlight.year.toString();
}
