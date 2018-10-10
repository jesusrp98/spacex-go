import 'vehicle_details.dart';

/// CAPSULE DETAILS CLASS
/// This class represents a real capsule used in a CRS mission,
/// with all its details.
class CapsuleDetails extends VehicleDetails {
  final String name;
  final int landings;

  CapsuleDetails({
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
      firstLaunched: DateTime.parse(json['original_launch']).toLocal(),
      missions: json['missions'],
      name: json['type'],
      landings: json['landings'],
    );
  }

  String get getDetails => details ?? 'This capsule has currently no details.';

  String get getLandings => landings.toString();
}
