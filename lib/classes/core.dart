/// CORE CLASS
/// This class is used in conjunction with the 'launch.dart' class, to retrieve
/// core information from the rocket used in a specific mission.
class Core {
  final String id, landingType, landingZone;
  final bool reused, landingSuccess, landingIntent;
  final int block, flights;

  Core({
    this.id,
    this.landingType,
    this.landingZone,
    this.reused,
    this.landingSuccess,
    this.landingIntent,
    this.block,
    this.flights,
  });

  factory Core.fromJson(Map<String, dynamic> json) {
    return Core(
      id: json['core_serial'],
      landingType: json['landing_type'],
      landingZone: json['landing_vehicle'],
      reused: json['reused'],
      landingSuccess: json['land_success'],
      landingIntent: json['landing_intent'],
      block: json['block'],
      flights: json['flight'],
    );
  }

  String get getId => id ?? 'Unknown';

  String get getLandingType => landingType ?? 'Unknown';

  String get getLandingZone => landingZone ?? 'Unknown';

  String get getBlock => block == null ? 'Unknown' : 'Block $block';

  String get getFlights => flights == null ? 'Unknown' : flights.toString();
}
