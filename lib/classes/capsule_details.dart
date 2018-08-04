import 'package:intl/intl.dart';

// FILE NOT IN USE

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
      firstLaunched: DateTime.fromMillisecondsSinceEpoch(
        json['original_launch_unix'] * 1000,
      ),
      landings: json['landings'],
      details: json['details'],
    );
  }

  String get getStatus => '${status[0].toUpperCase()}${status.substring(1)}';

  String get getFirstLaunched =>
      '${DateFormat('MMMM yyyy').format(firstLaunched)}';

  String get getDetails => details ?? 'This capsule has currently no details.';
}
