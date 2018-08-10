/// LAUNCHPAD INFO CLASS
/// This class represents a real launchpad used in a SpaceX mission,
/// with all its details.
class LaunchpadInfo {
  final String name;
  final String status;
  final String location;
  final String state;
  final List<double> coordinates;
  final String details;

  LaunchpadInfo({
    this.name,
    this.status,
    this.location,
    this.state,
    this.coordinates,
    this.details,
  });

  factory LaunchpadInfo.fromJson(Map<String, dynamic> json) {
    return LaunchpadInfo(
      name: json['full_name'],
      status: json['status'],
      location: json['location']['name'],
      state: json['location']['region'],
      coordinates: [
        json['location']['latitude'],
        json['location']['longitude'],
      ],
      details: json['details'],
    );
  }

  String get getStatus => '${status[0].toUpperCase()}${status.substring(1)}';

  String get getCoordinates => (coordinates[0].toStringAsPrecision(5) +
      ',  ' +
      coordinates[1].toStringAsPrecision(5));
}
