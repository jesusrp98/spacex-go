import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../util/photos.dart';
import '../../util/url.dart';
import '../classes/abstract/query_model.dart';
import 'index.dart';

/// Details about a specific capsule used in a CRS mission.
class CapsuleModel extends QueryModel {
  // Capsule serial: C0000
  final String id;

  CapsuleModel(this.id);

  @override
  Future loadData([BuildContext context]) async {
    if (await canLoadData()) {
      if (id != null) {
        // Fetch & add item
        items.add(
          CapsuleDetails.fromJson(await fetchData(Url.capsuleDialog + id)),
        );

        // Add photos & shuffle them
        photos.addAll(SpaceXPhotos.dragons);
        photos.shuffle();
      }
      finishLoading();
    }
  }

  CapsuleDetails get capsule => getItem(0);
}

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
      missions: json['missions']
          .map((mission) => MissionItem.fromJson(mission))
          .toList(),
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
