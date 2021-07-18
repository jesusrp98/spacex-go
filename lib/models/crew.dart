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
  final String role;

  const Crew({
    this.name,
    this.agency,
    this.imageUrl,
    this.wikipediaUrl,
    this.launches,
    this.status,
    this.id,
    this.role,
  });

  factory Crew.fromJson(Map<String, dynamic> json) {
    return Crew(
      name: json['crew']['name'],
      agency: json['crew']['agency'],
      imageUrl: json['crew']['image'],
      wikipediaUrl: json['crew']['wikipedia'],
      launches: (json['crew']['launches'] as List)
          .map((launch) => LaunchDetails.fromJson(launch))
          .toList(),
      status: json['crew']['status'],
      id: json['crew']['id'],
      role: json['role'],
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
        role,
      ];
}
