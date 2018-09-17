/// LAUNCHPAD INFO CLASS
/// This class represents a real launchpad used in a SpaceX mission,
/// with all its details.
class LaunchpadInfo {
  final String name, status, location, state, details;
  final List<double> coordinates;

  LaunchpadInfo({
    this.name,
    this.status,
    this.location,
    this.state,
    this.details,
    this.coordinates,
  });

  factory LaunchpadInfo.fromJson(Map<String, dynamic> json) {
    return LaunchpadInfo(
      name: json['site_name_long'],
      status: json['status'],
      location: json['location']['name'],
      state: json['location']['region'],
      details: json['details'],
      coordinates: [
        json['location']['latitude'],
        json['location']['longitude'],
      ],
    );
  }

  String get getStatus => '${status[0].toUpperCase()}${status.substring(1)}';

  String get getCoordinates => (coordinates[0].toStringAsPrecision(5) +
      ',  ' +
      coordinates[1].toStringAsPrecision(5));
}
