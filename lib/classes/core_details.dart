import 'package:intl/intl.dart';

class CoreDetails {
  final String serial;
  final int block;
  final String status;
  final DateTime firstLaunched;
  final int landings;
  final String details;

  CoreDetails(
      {this.serial,
      this.block,
      this.status,
      this.firstLaunched,
      this.landings,
      this.details});

  factory CoreDetails.fromJson(Map<String, dynamic> json) {
    return CoreDetails(
        serial: json['core_serial'],
        block: json['block'],
        status: json['status'],
        firstLaunched: DateTime
            .fromMillisecondsSinceEpoch(json['original_launch_unix'] * 1000),
        landings: json['rtls_landings'] + json['asds_landings'],
        details: json['details']);
  }

  String getBlock() {
    return 'Block $block';
  }

  String getStatus() {
    return '${status[0].toUpperCase()}${status.substring(1)}';
  }

  String getFirstLaunched() {
    return '${DateFormat('dd/MM/yyyy').format(firstLaunched)}';
  }

  String getDetails() {
    return details == null ? 'This core has currently no details.' : details;
  }
}
