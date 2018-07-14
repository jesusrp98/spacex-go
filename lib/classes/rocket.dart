import 'core.dart';
import 'second_stage.dart';

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
          .map((m) => new Core.fromJson(m))
          .toList(),
      secondStage: SecondStage.fromJson(json['second_stage']),
    );
  }

  String getName() {
    return name;
  }

  String getType() {
    return type;
  }

  List<Core> getFirstStage() {
    return firstStage;
  }

  bool isHeavy() {
    return firstStage.length != 1;
  }

  Core getCentralCore() {
    return firstStage[0];
  }

  Core getLeftBooster() {
    return firstStage[1];
  }

  Core getRightBooster() {
    return firstStage[2];
  }

  bool isCoreReused() {
    return getCentralCore().reused;
  }

  bool isLeftBoosterReused() {
    return getLeftBooster().reused;
  }

  bool isRightBoosterReused() {
    return getRightBooster().reused;
  }

  SecondStage getSecondStage() {
    return secondStage;
  }
}
