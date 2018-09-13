import 'package:intl/intl.dart';

///CORE DETAILS CLASS
/// This class represents a single core used in a SpaceX mission,
/// with all its details.
class CoreDetails {
  final String serial;
  final int block;
  final String status;
  final DateTime firstLaunched;
  final int rtlsLandings;
  final int asdsLandings;
  final int launches;
  final List missions;
  final String details;

  CoreDetails({
    this.serial,
    this.block,
    this.status,
    this.firstLaunched,
    this.rtlsLandings,
    this.asdsLandings,
    this.launches,
    this.missions,
    this.details,
  });

  factory CoreDetails.fromJson(Map<String, dynamic> json) {
    return CoreDetails(
      serial: json['core_serial'],
      block: json['block'],
      status: json['status'],
      firstLaunched: DateTime.parse(json['original_launch']).toLocal(),
      rtlsLandings: json['rtls_landings'],
      asdsLandings: json['asds_landings'],
      launches: (json['missions'] as List).length,
      missions: json['missions'],
      details: json['details'],
    );
  }

  String get getBlock => block == null ? 'Unknown' : 'Block $block';

  String get getStatus => '${status[0].toUpperCase()}${status.substring(1)}';

  String get getFirstLaunched => DateFormat.yMMMM().format(firstLaunched);

  String get getRtlsLandings => rtlsLandings.toString();

  String get getAsdsLandings => asdsLandings.toString();

  String get getMissions {
    String allMissions = '';
    if (missions.isEmpty)
      return 'No previous missions.';
    else {
      missions.forEach(
        (mission) =>
            allMissions += mission + ((mission != missions.last) ? ',  ' : '.'),
      );
      return allMissions;
    }
  }

  String get getLaunches => launches.toString();

  String get getDetails => details ?? 'This core has currently no details.';
}
