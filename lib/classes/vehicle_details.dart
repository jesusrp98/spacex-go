import 'package:intl/intl.dart';

abstract class VehicleDetails {
  final String serial, status, details;
  final DateTime firstLaunched;
  final List missions;

  VehicleDetails({
    this.serial,
    this.status,
    this.details,
    this.firstLaunched,
    this.missions,
  });

  String get getStatus => '${status[0].toUpperCase()}${status.substring(1)}';

  String get getDetails;

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
