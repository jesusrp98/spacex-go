import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

/// Details about a specific launchpad, where rockets are launched from.
class LaunchpadDetails extends Equatable {
  final String name;
  final String fullName;
  final String locality;
  final String region;
  final double latitude;
  final double longitude;
  final int launchAttempts;
  final int launchSuccesses;
  final String status;
  final String details;
  final String imageUrl;
  final String id;

  const LaunchpadDetails({
    this.name,
    this.fullName,
    this.locality,
    this.region,
    this.latitude,
    this.longitude,
    this.launchAttempts,
    this.launchSuccesses,
    this.status,
    this.details,
    this.imageUrl,
    this.id,
  });

  factory LaunchpadDetails.fromJson(Map<String, dynamic> json) {
    return LaunchpadDetails(
      name: json['name'],
      fullName: json['full_name'],
      locality: json['locality'],
      region: json['region'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      launchAttempts: json['launch_attempts'],
      launchSuccesses: json['launch_successes'],
      status: json['status'],
      details: json['details'],
      imageUrl: json['images']['large'][0],
      id: json['id'],
    );
  }

  LatLng get coordinates => LatLng(latitude, longitude);

  String get getStatus => toBeginningOfSentenceCase(status);

  String get getCoordinates =>
      '${coordinates.latitude.toStringAsPrecision(5)},  ${coordinates.longitude.toStringAsPrecision(5)}';

  String get getSuccessfulLaunches => '$launchSuccesses/$launchAttempts';

  @override
  List<Object> get props => [
        name,
        fullName,
        locality,
        region,
        latitude,
        longitude,
        launchAttempts,
        launchSuccesses,
        details,
        id,
      ];
}
