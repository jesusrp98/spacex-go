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
      date: json['date_utc'] != null ? DateTime.parse(json['date_utc']) : null,
      id: json['id'],
    );
  }

  DateTime get localDate => date.toLocal();

  @override
  List<Object> get props => [
        flightNumber,
        name,
        date,
        id,
      ];
}
