import 'vehicle_details.dart';

///CORE DETAILS CLASS
/// This class represents a single core used in a SpaceX mission,
/// with all its details.
class CoreDetails extends VehicleDetails {
  final int block, rtlsLandings, asdsLandings;

  CoreDetails({
    serial,
    status,
    details,
    firstLaunched,
    missions,
    this.block,
    this.rtlsLandings,
    this.asdsLandings,
  }) : super(
          serial: serial,
          status: status,
          details: details,
          firstLaunched: firstLaunched,
          missions: missions,
        );

  factory CoreDetails.fromJson(Map<String, dynamic> json) {
    return CoreDetails(
      serial: json['core_serial'],
      status: json['status'],
      details: json['details'],
      firstLaunched: DateTime.parse(json['original_launch']).toLocal(),
      missions: json['missions'],
      block: json['block'],
      rtlsLandings: json['rtls_landings'],
      asdsLandings: json['asds_landings'],
    );
  }

  String get getDetails => details ?? 'This core has currently no details.';

  String get getBlock => block == null ? 'Unknown' : 'Block $block';

  String get getRtlsLandings => rtlsLandings.toString();

  String get getAsdsLandings => asdsLandings.toString();
}
