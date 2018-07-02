class Core {
  final String id;
  final int flights;
  final int block;
  final bool reused;
  final bool landingSuccess;
  final String landingZone;

  Core(
      {this.id,
      this.flights,
      this.block,
      this.reused,
      this.landingSuccess,
      this.landingZone});

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

  String getId() {
    return id == null ? 'Unknown.' : id;
  }

  String getFlights() {
    return flights == null ? 'Unknown.' : flights.toString();
  }

  String getBlock() {
    return block == null ? 'Unknown.' : block.toString();
  }

  String isReused() {
    return reused == null ? 'Unknown.' : (reused ? 'Yes.' : 'No.');
  }

  String isLandingSuccess() {
    return landingSuccess == null
        ? 'Unknown.'
        : (landingSuccess ? 'Yes.' : 'No.');
  }

  String getLandingZone() {
    return landingZone == null ? 'Unknown.' : landingZone;
  }
}
