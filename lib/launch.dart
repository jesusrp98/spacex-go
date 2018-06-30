import 'core.dart';

class Launch {
    final int missionNumber;
    final String missionName;
    final String missionDate;

    final String rocketName;

    final List<Core> cores;

    final String siteName;
    final String siteNameLong;

    final String missionOrbit;

    Launch({this.missionNumber, this.missionName, this.missionDate, this.rocketName,
        this.cores, this.siteName, this.siteNameLong, this.missionOrbit});

    factory Launch.fromJson(Map<String, dynamic> json) {
        return Launch(
            missionNumber: json['flight_number'],
            missionName: json['mission_name'],
            missionDate: json['launch_date_utc'],
            //TODO ...
        );
    }
}