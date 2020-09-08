import 'package:equatable/equatable.dart';

/// TODO
class LaunchDetails extends Equatable {
  final int flightNumber;
  final String name;
  final String id;

  const LaunchDetails({
    this.flightNumber,
    this.name,
    this.id,
  });

  factory LaunchDetails.fromJson(Map<String, dynamic> json) {
    return LaunchDetails(
      flightNumber: json['flight_number'],
      name: json['name'],
      id: json['id'],
    );
  }

  @override
  List<Object> get props => [
        flightNumber,
        name,
        id,
      ];
}
