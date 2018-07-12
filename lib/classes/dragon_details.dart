import 'package:intl/intl.dart';

class DragonDetails {
  final String name;
  final String serial;
  final String status;
  final DateTime firstLaunched;
  final int landings;
  final String details;

  DragonDetails(
      {this.name,
      this.serial,
      this.status,
      this.firstLaunched,
      this.landings,
      this.details});

  factory DragonDetails.fromJson(Map<String, dynamic> json) {
    return DragonDetails(
      name: json['type'],
      serial: json['capsule_serial'],
      status: json['status'],
      firstLaunched: DateTime
          .fromMillisecondsSinceEpoch(json['original_launch_unix'] * 1000),
      landings: json['landings'],
      details: json['details'],
    );
  }

  String getStatus() {
    return '${status[0].toUpperCase()}${status.substring(1)}';
  }

  String getFirstLaunched() {
    return '${DateFormat('MMMM yyyy').format(firstLaunched)}';
  }

  String getDetails() {
    return details == null ? 'This capsule has currently no details.' : details;
  }
}
