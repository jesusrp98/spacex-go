import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';

/// Details about a specific launchpad, where rockets are launched from.
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

  String get getStatus => toBeginningOfSentenceCase(status);

  String get getCoordinates =>
      '${coordinates.latitude.toStringAsPrecision(5)},  ${coordinates.longitude.toStringAsPrecision(5)}';

  String get getSuccessfulLaunches => '$successfulLaunches/$attemptedLaunches';
}
