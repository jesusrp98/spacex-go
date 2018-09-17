import 'package:intl/intl.dart';

/// CAPSULE DETAILS CLASS
/// This class represents a real capsule used in a CRS mission,
/// with all its details.
class CapsuleDetails {
  final String serial, name, status, details;
  final DateTime firstLaunched;
  final int landings;

  CapsuleDetails({
    this.serial,
    this.name,
    this.status,
    this.details,
    this.firstLaunched,
    this.landings,
  });

  factory CapsuleDetails.fromJson(Map<String, dynamic> json) {
    return CapsuleDetails(
      serial: json['capsule_serial'],
      name: json['type'],
      status: json['status'],
      details: json['details'],
      firstLaunched: DateTime.parse(json['original_launch']).toLocal(),
      landings: json['landings'],
    );
  }

  String get getStatus => '${status[0].toUpperCase()}${status.substring(1)}';

  String get getDetails => details ?? 'This capsule has currently no details.';

  String get getFirstLaunched => DateFormat.yMMMM().format(firstLaunched);

  String get getLandings => landings.toString();
}
