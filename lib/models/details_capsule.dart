import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'index.dart';

/// Details about a specific capsule used in a CRS mission.
class CapsuleDetails extends VehicleDetails {
  final String name;
  final int landings;

  const CapsuleDetails({
    serial,
    status,
    details,
    firstLaunched,
    missions,
    this.name,
    this.landings,
  }) : super(
          serial: serial,
          status: status,
          details: details,
          firstLaunched: firstLaunched,
          missions: missions,
        );

  factory CapsuleDetails.fromJson(Map<String, dynamic> json) {
    return CapsuleDetails(
      serial: json['capsule_serial'],
      status: json['status'],
      details: json['details'],
      firstLaunched: json['original_launch'] != null
          ? DateTime.parse(json['original_launch'])
          : null,
      missions: [
        for (final item in json['missions']) MissionItem.fromJson(item)
      ],
      name: json['type'],
      landings: json['landings'],
    );
  }

  @override
  String getDetails(BuildContext context) =>
      details ??
      FlutterI18n.translate(
        context,
        'spacex.dialog.vehicle.no_description_capsule',
      );

  String get getSplashings => landings.toString();
}
