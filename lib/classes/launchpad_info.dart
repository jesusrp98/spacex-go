class LaunchpadInfo {
  final String name;
  final String status;
  final String locationName;
  final List<double> coordinates;
  final String details;

  LaunchpadInfo(
      {this.name,
      this.status,
      this.locationName,
      this.coordinates,
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
        details: json['details']);
  }

  String getStatus() {
    return '${status[0].toUpperCase()}${status.substring(1)}';
  }

  String getCoordinates() {
    return (coordinates[0].toStringAsPrecision(5) +
        ', ' +
        coordinates[1].toStringAsPrecision(5));
  }
}
