import 'package:intl/intl.dart';

/// CAPSULE DETAILS CLASS
/// This class represents a real capsule used in a CRS mission,
/// with all its details.
class CapsuleDetails {
  final String name;
  final String serial;
  final String status;
  final DateTime firstLaunched;
  final int landings;
  final String details;

  CapsuleDetails({
    this.name,
    this.serial,
    this.status,
    this.firstLaunched,
    this.landings,
    this.details,
  });

  factory CapsuleDetails.fromJson(Map<String, dynamic> json) {
    return CapsuleDetails(
      name: json['type'],
      serial: json['capsule_serial'],
      status: json['status'],
      firstLaunched: DateTime.parse(json['original_launch']).toLocal(),
      landings: json['landings'],
      details: json['details'],
    );
  }

  String get getStatus => '${status[0].toUpperCase()}${status.substring(1)}';

  String get getFirstLaunched => DateFormat.yMMMM().format(firstLaunched);

  String get getLandings => landings.toString();

  String get getDetails => details ?? 'This capsule has currently no details.';
}
