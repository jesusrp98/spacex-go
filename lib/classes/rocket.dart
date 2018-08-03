import 'package:cherry/classes/core.dart';
import 'package:cherry/classes/second_stage.dart';

class Rocket {
  final String id;
  final String name;
  final String type;
  final List<Core> firstStage;
  final SecondStage secondStage;

  Rocket({this.id, this.name, this.type, this.firstStage, this.secondStage});

  factory Rocket.fromJson(Map<String, dynamic> json) {
    return Rocket(
      id: json['rocket_id'],
      name: json['rocket_name'],
      type: json['rocket_type'],
      firstStage: (json['first_stage']['cores'] as List)
          .map((m) => Core.fromJson(m))
          .toList(),
      secondStage: SecondStage.fromJson(json['second_stage']),
    );
  }

  bool get isHeavy => firstStage.length != 1;

  Core get getCentralCore => firstStage[0];

  Core get getLeftBooster => firstStage[1];

  Core get getRightBooster => firstStage[2];

  bool get isCoreReused => getCentralCore.reused;

  bool get isLeftBoosterReused => getLeftBooster.reused;

  bool get isRightBoosterReused => getRightBooster.reused;
}
