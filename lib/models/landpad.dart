import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

/// Details about a specific landpad,
/// where boosters can land after completing its mission.
class LandpadDetails extends Equatable {
  final String name;
  final String fullName;
  final String type;
  final String locality;
  final String region;
  final double latitude;
  final double longitude;
  final int landingAttempts;
  final int landingSuccesses;
  final String wikipediaUrl;
  final String details;
  final String status;
  final String imageUrl;
  final String id;

  const LandpadDetails({
    this.name,
    this.fullName,
    this.type,
    this.locality,
    this.region,
    this.latitude,
    this.longitude,
    this.landingAttempts,
    this.landingSuccesses,
    this.wikipediaUrl,
    this.details,
    this.status,
    this.imageUrl,
    this.id,
  });

  factory LandpadDetails.fromJson(Map<String, dynamic> json) {
    return LandpadDetails(
      name: json['name'],
      fullName: json['full_name'],
      type: json['type'],
      locality: json['locality'],
      region: json['region'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      landingAttempts: json['landing_attempts'],
      landingSuccesses: json['landing_successes'],
      wikipediaUrl: json['wikipedia'],
      details: json['details'],
      status: json['status'],
      imageUrl: json['images']['large'][0],
      id: json['id'],
    );
  }

  LatLng get coordinates => LatLng(latitude, longitude);

  String get getStatus => toBeginningOfSentenceCase(status);

  String get getCoordinates =>
      '${coordinates.latitude.toStringAsPrecision(5)},  ${coordinates.longitude.toStringAsPrecision(5)}';

  String get getSuccessfulLandings => '$landingSuccesses/$landingAttempts';

  @override
  List<Object> get props => [
        name,
        fullName,
        type,
        locality,
        region,
        latitude,
        longitude,
        landingAttempts,
        landingSuccesses,
        wikipediaUrl,
        details,
        status,
        id,
      ];
}
