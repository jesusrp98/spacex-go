import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

import '../util/url.dart';
import 'query_model.dart';

/// LANDPAD MODEL
/// Details about a specific landpad,
/// where boosters can land after completing its mission.
class LandpadModel extends QueryModel {
  // Landpad id: OCISLY
  final String id;

  LandpadModel(this.id);

  @override
  Future loadData([BuildContext context]) async {
    if (await connectionFailure())
      receivedError();
    else {
      // Fetch & add item
      items.add(Landpad.fromJson(await fetchData(Url.landingpadDialog + id)));

      finishLoading();
    }
  }

  Landpad get landpad => items[0];
}

class Landpad {
  final String name, status, type, location, state, details, url;
  final LatLng coordinates;
  final int attemptedLandings, successfulLandings;

  Landpad({
    this.name,
    this.status,
    this.type,
    this.location,
    this.state,
    this.details,
    this.url,
    this.coordinates,
    this.attemptedLandings,
    this.successfulLandings,
  });

  factory Landpad.fromJson(Map<String, dynamic> json) {
    return Landpad(
      name: json['full_name'],
      status: json['status'],
      type: json['landing_type'],
      location: json['location']['name'],
      state: json['location']['region'],
      details: json['details'],
      url: json['wikipedia'],
      coordinates: LatLng(
        json['location']['latitude'],
        json['location']['longitude'],
      ),
      attemptedLandings: json['attempted_landings'],
      successfulLandings: json['successful_landings'],
    );
  }

  String get getStatus => '${status[0].toUpperCase()}${status.substring(1)}';

  String get getCoordinates =>
      '${coordinates.latitude.toStringAsPrecision(5)},  ${coordinates.longitude.toStringAsPrecision(5)}';

  String get getSuccessfulLandings => '$successfulLandings/$attemptedLandings';
}
