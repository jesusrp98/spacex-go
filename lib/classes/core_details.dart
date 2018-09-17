import 'package:intl/intl.dart';

///CORE DETAILS CLASS
/// This class represents a single core used in a SpaceX mission,
/// with all its details.
class CoreDetails {
  final String serial, status, details;
  final int block, rtlsLandings, asdsLandings;
  final DateTime firstLaunched;
  final List missions;

  CoreDetails({
    this.serial,
    this.status,
    this.details,
    this.block,
    this.rtlsLandings,
    this.asdsLandings,
    this.firstLaunched,
    this.missions,
  });

  factory CoreDetails.fromJson(Map<String, dynamic> json) {
    return CoreDetails(
      serial: json['core_serial'],
      status: json['status'],
      details: json['details'],
      block: json['block'],
      rtlsLandings: json['rtls_landings'],
      asdsLandings: json['asds_landings'],
      firstLaunched: DateTime.parse(json['original_launch']).toLocal(),
      missions: json['missions'],
    );
  }

  String get getStatus => '${status[0].toUpperCase()}${status.substring(1)}';

  String get getDetails => details ?? 'This core has currently no details.';

  String get getBlock => block == null ? 'Unknown' : 'Block $block';

  String get getRtlsLandings => rtlsLandings.toString();

  String get getAsdsLandings => asdsLandings.toString();

  String get getFirstLaunched => DateFormat.yMMMM().format(firstLaunched);

  String get getMissions {
    String allMissions = '';
    if (missions.isEmpty)
      return 'No previous missions.';
    else {
      missions.forEach(
        (mission) => allMissions +=
            mission['name'] + ((mission != missions.last) ? ',  ' : '.'),
      );
      return allMissions;
    }
  }

  String get getLaunches => missions.length.toString();
}
