import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'index.dart';

/// Details about a specific core or booster used in a specific mission.
class CoreDetails extends VehicleDetails {
  final int block, rtlsLandings, rtlsAttempts, asdsLandings, asdsAttempts;

  const CoreDetails({
    serial,
    status,
    details,
    firstLaunched,
    missions,
    this.block,
    this.rtlsLandings,
    this.rtlsAttempts,
    this.asdsLandings,
    this.asdsAttempts,
  }) : super(
          serial: serial,
          status: status,
          details: details,
          firstLaunched: firstLaunched,
          missions: missions,
        );

  factory CoreDetails.fromJson(Map<String, dynamic> json) {
    return CoreDetails(
      serial: json['core_serial'],
      status: json['status'],
      details: json['details'],
      firstLaunched: json['original_launch'] != null
          ? DateTime.parse(json['original_launch'])
          : null,
      missions: [
        for (final item in json['missions']) MissionItem.fromJson(item)
      ],
      block: json['block'],
      rtlsLandings: json['rtls_landings'],
      rtlsAttempts: json['rtls_attempts'],
      asdsLandings: json['asds_landings'],
      asdsAttempts: json['asds_attempts'],
    );
  }

  @override
  String getDetails(BuildContext context) =>
      details ??
      FlutterI18n.translate(
        context,
        'spacex.dialog.vehicle.no_description_core',
      );

  String getBlock(BuildContext context) => block == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : FlutterI18n.translate(
          context,
          'spacex.other.block',
          translationParams: {'block': block.toString()},
        );

  String get getRtlsLandings => '$rtlsLandings/$rtlsAttempts';

  String get getAsdsLandings => '$asdsLandings/$asdsAttempts';
}
