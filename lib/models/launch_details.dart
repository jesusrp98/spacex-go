import 'package:equatable/equatable.dart';

/// Storages basic details about a rocket launch.
/// It serves as a direct link to its details.
class LaunchDetails extends Equatable {
  final int flightNumber;
  final String name;
  final DateTime date;
  final String id;

  const LaunchDetails({
    this.flightNumber,
    this.name,
    this.date,
    this.id,
  });

  factory LaunchDetails.fromJson(Map<String, dynamic> json) {
    return LaunchDetails(
      flightNumber: json['flight_number'],
      name: json['name'],
      date: DateTime.parse(json['date_utc']),
      id: json['id'],
    );
  }

  @override
  List<Object> get props => [
        flightNumber,
        name,
        date,
        id,
      ];
}
