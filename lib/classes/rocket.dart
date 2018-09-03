import 'package:cherry/classes/core.dart';
import 'package:cherry/classes/fairing.dart';
import 'package:cherry/classes/second_stage.dart';

/// ROCKET CLASS
/// This class is used in the Launch class, to represent a rocket object. It has
/// a list of cores, and a second stage.
class Rocket {
  final String id;
  final String name;
  final String type;
  final List<Core> firstStage;
  final SecondStage secondStage;
  final Fairing fairing;

  Rocket({
    this.id,
    this.name,
    this.type,
    this.firstStage,
    this.secondStage,
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
      fairing: Fairing.fromJson(json['fairings']),
    );
  }

  bool get isHeavy => firstStage.length != 1;

  Core get centralCore => firstStage[0];

  Core get leftBooster => firstStage[1];

  Core get rightBooster => firstStage[2];

  bool get coreReused => centralCore.reused;

  bool get leftBoosterReused => leftBooster.reused;

  bool get rightBoosterReused => rightBooster.reused;
}
