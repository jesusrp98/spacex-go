/// CORE CLASS
/// This class is used in conjunction with the 'launch.dart' class, to retrieve
/// core information from the rocket used in a specific mission.
class Core {
  final String id;
  final int flights;
  final int block;
  final bool reused;
  final bool landingSuccess;
  final String landingZone;

  Core({
    this.id,
    this.flights,
    this.block,
    this.reused,
    this.landingSuccess,
    this.landingZone,
  });

  factory Core.fromJson(Map<String, dynamic> json) {
    return Core(
      id: json['core_serial'],
      flights: json['flight'],
      block: json['block'],
      reused: json['reused'],
      landingSuccess: json['land_success'],
      landingZone: json['landing_vehicle'],
    );
  }

  String get getId => id ?? 'Unknown';

  String get getFlights => flights == null ? 'Unknown' : flights.toString();

  String get getBlock => block == null ? 'Unknown' : 'Block $block';

  String get getLandingZone => landingZone ?? 'Unknown';
}
