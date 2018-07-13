import 'vehicle.dart';

class RocketInfo extends Vehicle {
  final int stages;
  final int launchCost;
  final int successRate;
  final DateTime firstLaunched;
  final num height;
  final num diameter;
  final num mass;
  //final Map<String, num> payloadWeights;
  final bool isReusable;
  final String engine;
  final List<int> engineConfiguration;
  final num engineThrustSea;
  final num engineThrustVacuum;
  final int legs;
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
      //this.payloadWeights,
      this.engineConfiguration,
      this.isReusable,
      this.engine,
      this.engineThrustSea,
      this.engineThrustVacuum,
      this.legs,
      this.details})
      : super(id, name, type, isActive);

  factory RocketInfo.fromJson(Map<String, dynamic> json) {
    return RocketInfo(
        id: json['id'],
        name: json['name'],
        isActive: json['active'],
        stages: json['stages'],
        launchCost: json['cost_per_launch'],
        successRate: json['success_race_pct'],
        firstLaunched: DateTime.parse(json['first_flight']),
        height: json['height']['meters'],
        diameter: json['diameter']['meters'],
        mass: json['mass']['kg'],
        //payloadWeights: {json['payload_weights']},
        isReusable: json['first_stage']['reusable'],
        engine: json['engines']['type'] + ', ' + json['engines']['version'],
        //TODO could fail
        /*engineConfiguration: [
          json['first_stage']['engines'],
          json['second_stage']['engines']
        ],*/
        engineThrustSea: json['engines']['thrust_sea_level']['kN'],
        engineThrustVacuum: json['engines']['thrust_vacuum']['kN'],
        legs: json['landing_legs']['number'],
        details: json['description']);
  }

  String getStatus() {
    return isActive ? 'Active' : 'Retired';
  }
}
