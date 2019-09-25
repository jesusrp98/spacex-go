import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

import '../../util/url.dart';
import '../classes/abstract/query_model.dart';

/// Details about a specific launchpad, where rockets are launched from.
/// Launchpad [id] : ccafs_slc_40
/// Launchpad [name]: Cape Canaveral Air Force Station Space Launch Complex 40
class LaunchpadModel extends QueryModel {
  final String id, name;

  LaunchpadModel(this.id, this.name);

  @override
  Future loadData([BuildContext context]) async {
    if (await canLoadData()) {
      // Fetch & add item
      items.add(Launchpad.fromJson(await fetchData(Url.launchpadDialog + id)));

      finishLoading();
    }
  }

  Launchpad get launchpad => getItem(0);
}

class Launchpad {
  final String name, status, location, state, details, url;
  final LatLng coordinates;
  final int attemptedLaunches, successfulLaunches;

  const Launchpad({
    this.name,
    this.status,
    this.location,
    this.state,
    this.details,
    this.url,
    this.coordinates,
    this.attemptedLaunches,
    this.successfulLaunches,
  });

  factory Launchpad.fromJson(Map<String, dynamic> json) {
    return Launchpad(
      name: json['site_name_long'],
      status: json['status'],
      location: json['location']['name'],
      state: json['location']['region'],
      details: json['details'],
      url: json['wikipedia'],
      coordinates: LatLng(
        json['location']['latitude'],
        json['location']['longitude'],
      ),
      attemptedLaunches: json['attempted_launches'],
      successfulLaunches: json['successful_launches'],
    );
  }

  String get getStatus => '${status[0].toUpperCase()}${status.substring(1)}';

  String get getCoordinates =>
      '${coordinates.latitude.toStringAsPrecision(5)},  ${coordinates.longitude.toStringAsPrecision(5)}';

  String get getSuccessfulLaunches => '$successfulLaunches/$attemptedLaunches';
}
