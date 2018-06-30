class Core {
  final String id;
  final int flights;
  final int block;
  final bool reused;
  final bool landSuccess;
  final String landingZone;

  Core(
      {this.id,
      this.flights,
      this.block,
      this.reused,
      this.landSuccess,
      this.landingZone});

  factory Core.fromJson(Map<String, dynamic> json) {
    return Core(
      id: json['core_serial'],
      flights: json['flight'],
      block: json['block'],
      reused: json['reused'],
      landSuccess: json['land_success'],
      landingZone: json['landing_vehicle'],
    );
  }
}
