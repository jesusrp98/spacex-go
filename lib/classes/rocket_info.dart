import 'package:intl/intl.dart';
import 'vehicle.dart';

class RocketInfo extends Vehicle {
  final int stages;
  final int launchCost;
  final int successRate;
  final DateTime firstLaunched;
  final num height;
  final num diameter;
  final num mass;
  final List<PayloadWeight> payloadWeights;
  final String engine;
  final List<int> engineConfiguration;
  final num engineThrustSea;
  final num engineThrustVacuum;
  final String details;

  RocketInfo(
      {id,
      name,
      type,
      isActive,
      this.stages,
      this.launchCost,
      this.successRate,
      this.firstLaunched,
      this.height,
      this.diameter,
      this.mass,
      this.payloadWeights,
      this.engineConfiguration,
      this.engine,
      this.engineThrustSea,
      this.engineThrustVacuum,
      this.details})
      : super(id, name, type, isActive);

  factory RocketInfo.fromJson(Map<String, dynamic> json) {
    return RocketInfo(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        isActive: json['active'],
        stages: json['stages'],
        launchCost: json['cost_per_launch'],
        successRate: json['success_rate_pct'],
        firstLaunched: DateTime.parse(json['first_flight']),
        height: json['height']['meters'],
        diameter: json['diameter']['meters'],
        mass: json['mass']['kg'],
        payloadWeights: (json['payload_weights'] as List)
            .map((payloadWeight) => PayloadWeight.fromJson(payloadWeight))
            .toList(),
        engine: json['engines']['type'] + ' ' + json['engines']['version'],
        engineConfiguration: [
          json['first_stage']['engines'],
          json['second_stage']['engines']
        ],
        engineThrustSea: json['engines']['thrust_sea_level']['kN'],
        engineThrustVacuum: json['engines']['thrust_vacuum']['kN'],
        details: json['description']);
  }

  String get getStages => stages.toString();

  String get getMass => '$mass kg';

  String get getHeight => '$height m';

  String get getDiameter => '$diameter m';

  String get getSuccessRate => '$successRate%';

  String get getLaunchCost => '\$$launchCost';

  String get getEngineThrustSea => '$engineThrustSea kN';

  String get getEngineThrustVacuum => '$engineThrustVacuum kN';

  String get getEngine => '${engine[0].toUpperCase()}${engine.substring(1)}';

  String get getFirstLaunched =>
      '${DateFormat('MMMM yyyy').format(firstLaunched)}';
}

class PayloadWeight {
  final String name;
  final int mass;

  PayloadWeight({this.name, this.mass});

  factory PayloadWeight.fromJson(Map<String, dynamic> json) {
    return PayloadWeight(name: json['name'], mass: json['kg']);
  }

  String get getMass => '$mass kg';
}
