import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../util/photos.dart';
import '../util/url.dart';
import 'details_vehicle.dart';
import 'mission_item.dart';
import 'query_model.dart';

/// CORE DETAILS MODEL
/// Details about a specific core or booster used in a specific mission.
class CoreModel extends QueryModel {
  // Core serial: B0000
  final String id;

  CoreModel(this.id);

  @override
  Future loadData([BuildContext context]) async {
    if (await connectionFailure())
      receivedError();
    else {
      if (id != null) {
        // Fetch & add item
        items.add(CoreDetails.fromJson(await fetchData(Url.coreDialog + id)));

        // Add photos & shuffle them
        photos.addAll(SpaceXPhotos.cores);
        photos.shuffle();
      }
      finishLoading();
    }
  }

  CoreDetails get core => items[0];
}

class CoreDetails extends VehicleDetails {
  final int block, rtlsLandings, rtlsAttempts, asdsLandings, asdsAttempts;

  CoreDetails({
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
      missions: json['missions']
          .map((mission) => MissionItem.fromJson(mission))
          .toList(),
      block: json['block'],
      rtlsLandings: json['rtls_landings'],
      rtlsAttempts: json['rtls_attempts'],
      asdsLandings: json['asds_landings'],
      asdsAttempts: json['asds_attempts'],
    );
  }

  String getDetails(context) =>
      details ??
      FlutterI18n.translate(
        context,
        'spacex.dialog.vehicle.no_description_core',
      );

  String getBlock(context) => block == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : FlutterI18n.translate(
          context,
          'spacex.other.block',
          {'block': block.toString()},
        );

  String get getRtlsLandings => '$rtlsLandings/$rtlsAttempts';

  String get getAsdsLandings => '$asdsLandings/$asdsAttempts';
}
