import 'package:equatable/equatable.dart';

import 'index.dart';

/// Auxiliary class to storage all details related to a member of a launch crew.
class Crew extends Equatable {
  final String name;
  final String agency;
  final String imageUrl;
  final String wikipediaUrl;
  final List<LaunchDetails> launches;
  final String status;
  final String id;

  const Crew({
    this.name,
    this.agency,
    this.imageUrl,
    this.wikipediaUrl,
    this.launches,
    this.status,
    this.id,
  });

  factory Crew.fromJson(Map<String, dynamic> json) {
    return Crew(
      name: json['name'],
      agency: json['agency'],
      imageUrl: json['image'],
      wikipediaUrl: json['wikipedia'],
      launches: (json['launches'] as List)
          .map((launch) => LaunchDetails.fromJson(launch))
          .toList(),
      status: json['status'],
      id: json['id'],
    );
  }

  @override
  List<Object> get props => [
        name,
        agency,
        imageUrl,
        wikipediaUrl,
        launches,
        status,
        id,
      ];
}
