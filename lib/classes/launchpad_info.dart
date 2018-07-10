class LaunchpadInfo {
  final String name;
  final String status;
  final String locationName;
  final List<double> coordinates;
//  final List<String> vehiclesLaunched;
  final String details;

  LaunchpadInfo(
      {this.name,
      this.status,
      this.locationName,
      this.coordinates,
//      this.vehiclesLaunched,
      this.details});

  factory LaunchpadInfo.fromJson(Map<String, dynamic> json) {
    return LaunchpadInfo(
        name: json['full_name'],
        status: json['status'],
        locationName:
            json['location']['name'] + ', ' + json['location']['region'],
        coordinates: [
          json['location']['latitude'],
          json['location']['longitude']
        ],
//        vehiclesLaunched: (json['vehicles_launched'] as List),
        details: json['details']);
  }
}