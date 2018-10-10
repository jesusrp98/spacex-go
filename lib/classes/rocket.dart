import 'core.dart';
import 'fairing.dart';
import 'second_stage.dart';

/// ROCKET CLASS
/// This class is used in the Launch class, to represent a rocket object. It has
/// a list of cores, and a second stage.
class Rocket {
  final String id, name, type;
  final List<Core> firstStage;
  final SecondStage secondStage;
  final bool hasFairing;
  final Fairing fairing;

  Rocket({
    this.id,
    this.name,
    this.type,
    this.firstStage,
    this.secondStage,
    this.hasFairing,
    this.fairing,
  });

  factory Rocket.fromJson(Map<String, dynamic> json) {
    return Rocket(
      id: json['rocket_id'],
      name: json['rocket_name'],
      type: json['rocket_type'],
      firstStage: (json['first_stage']['cores'] as List)
          .map((core) => Core.fromJson(core))
          .toList(),
      secondStage: SecondStage.fromJson(json['second_stage']),
      hasFairing: json['fairings'] != null,
      fairing:
          json['fairings'] == null ? null : Fairing.fromJson(json['fairings']),
    );
  }

  bool get isHeavy => firstStage.length != 1;
}
