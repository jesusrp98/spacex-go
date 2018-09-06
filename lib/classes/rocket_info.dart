import 'package:cherry/classes/vehicle.dart';
import 'package:intl/intl.dart';

/// ROCKET INFO CLASS
/// This class represents a model of a rocket, like Falcon 9 or BFR, with
/// all its specifications in place.
class RocketInfo extends Vehicle {
  final int stages;
  final int launchCost;
  final int successRate;
  final List<PayloadWeight> payloadWeights;
  final String engine;
  final List<int> engineConfiguration;
  final String fuel;
  final String oxidizer;
  final List<num> fairingDimensions;
  final num engineThrustSea;
  final num engineThrustVacuum;
  final num thrustToWeight;

  RocketInfo({
    id,
    name,
    type,
    active,
    firstFlight,
    height,
    diameter,
    mass,
    reusable,
    description,
    url,
    this.stages,
    this.launchCost,
    this.successRate,
    this.payloadWeights,
    this.engineConfiguration,
    this.engine,
    this.fuel,
    this.fairingDimensions,
    this.oxidizer,
    this.engineThrustSea,
    this.engineThrustVacuum,
    this.thrustToWeight,
  }) : super(
          id: id,
          name: name,
          type: type,
          active: active,
          firstFlight: firstFlight,
          height: height,
          diameter: diameter,
          mass: mass,
          reusable: reusable,
          description: description,
          url: url,
        );

  factory RocketInfo.fromJson(Map<String, dynamic> json) {
    return RocketInfo(
      id: json['rocket_id'],
      name: json['rocket_name'],
      type: json['rocket_type'],
      active: json['active'],
      firstFlight: DateTime.parse(json['first_flight']),
      height: json['height']['meters'],
      diameter: json['diameter']['meters'],
      mass: json['mass']['kg'],
      reusable: json['first_stage']['reusable'],
      description: json['description'],
      url: json['wikipedia'],
      stages: json['stages'],
      launchCost: json['cost_per_launch'],
      successRate: json['success_rate_pct'],
      payloadWeights: (json['payload_weights'] as List)
          .map((payloadWeight) => PayloadWeight.fromJson(payloadWeight))
          .toList(),
      engine: json['engines']['type'] + ' ' + json['engines']['version'],
      fairingDimensions: [
        json['second_stage']['payloads']['composite_fairing']['height']
            ['meters'],
        json['second_stage']['payloads']['composite_fairing']['diameter']
            ['meters'],
      ],
      fuel: json['engines']['propellant_2'],
      oxidizer: json['engines']['propellant_1'],
      engineConfiguration: [
        json['first_stage']['engines'],
        json['second_stage']['engines'],
      ],
      engineThrustSea: json['engines']['thrust_sea_level']['kN'],
      engineThrustVacuum: json['engines']['thrust_vacuum']['kN'],
      thrustToWeight: json['engines']['thrust_to_weight'],
    );
  }

  String get subtitle => firstLaunched;

  String get getStages => '$stages stages';

  String get getSuccessRate =>
      '${NumberFormat.percentPattern().format(successRate / 100)}';

  String get getLaunchCost =>
      '${NumberFormat.currency(symbol: "\$", decimalDigits: 0).format(launchCost)}';

  String get getEngineThrustSea =>
      '${NumberFormat.decimalPattern().format(engineThrustSea)} kN';

  String get getEngineThrustVacuum =>
      '${NumberFormat.decimalPattern().format(engineThrustVacuum)} kN';

  String get getThrustToWeight => thrustToWeight == null
      ? 'Unknown'
      : NumberFormat.decimalPattern().format(thrustToWeight);

  String get getEngine => '${engine[0].toUpperCase()}${engine.substring(1)}';

  String get firstStageEngines => engineConfiguration[0].toString();

  String get secondStageEngines => engineConfiguration[1].toString();

  String get fairingHeight => fairingDimensions[0] == null
      ? 'Unknown'
      : '${NumberFormat.decimalPattern().format(fairingDimensions[0])} m';

  String get fairingDiameter => fairingDimensions[1] == null
      ? 'Unknown'
      : '${NumberFormat.decimalPattern().format(fairingDimensions[1])} m';

  String get getFuel => '${fuel[0].toUpperCase()}${fuel.substring(1)}';

  String get getOxidizer =>
      '${oxidizer[0].toUpperCase()}${oxidizer.substring(1)}';
}

class PayloadWeight {
  final String name;
  final int mass;

  PayloadWeight({this.name, this.mass});

  factory PayloadWeight.fromJson(Map<String, dynamic> json) {
    return PayloadWeight(name: json['name'], mass: json['kg']);
  }

  String get getMass => '${NumberFormat.decimalPattern().format(mass)} kg';
}
