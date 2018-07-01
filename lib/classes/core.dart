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

  String getId() {
    return id == null ? 'Unknown.' : id;
  }

  String getFlights() {
    return flights == null ? 'Unknown.' : flights.toString();
  }

  String getBlock() {
    return block == null ? 'Unknown.' : block.toString();
  }

  String getReused() {
    return reused == null ? 'Unknown.' : (reused ? 'Yes.' : 'No.');
  }

  String getLandingSuccess() {
    return landSuccess == null ? 'Unknown.' : (landSuccess ? 'Yes.' : 'No.');
  }

  String getLandingZone() {
    return landingZone == null ? 'Unknown.' : landingZone;
  }
}
