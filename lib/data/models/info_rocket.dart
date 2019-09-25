import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

import 'info_vehicle.dart';

/// General information about a Falcon rocket.
class RocketInfo extends Vehicle {
  final num stages,
      launchCost,
      successRate,
      engineThrustSea,
      engineThrustVacuum,
      engineThrustToWeight;
  final List<PayloadWeight> payloadWeights;
  final String engine, fuel, oxidizer;
  final Stage firstStage, secondStage;
  final List<double> fairingDimensions;

  const RocketInfo({
    id,
    name,
    type,
    description,
    url,
    height,
    diameter,
    mass,
    active,
    firstFlight,
    photos,
    this.stages,
    this.launchCost,
    this.successRate,
    this.engineThrustSea,
    this.engineThrustVacuum,
    this.engineThrustToWeight,
    this.payloadWeights,
    this.engine,
    this.fuel,
    this.oxidizer,
    this.firstStage,
    this.secondStage,
    this.fairingDimensions,
  }) : super(
          id: id,
          name: name,
          type: type,
          description: description,
          url: url,
          height: height,
          diameter: diameter,
          mass: mass,
          active: active,
          firstFlight: firstFlight,
          photos: photos,
        );

  factory RocketInfo.fromJson(Map<String, dynamic> json) {
    return RocketInfo(
      id: json['rocket_id'],
      name: json['rocket_name'],
      type: json['rocket_type'],
      description: json['description'],
      url: json['wikipedia'],
      height: json['height']['meters'],
      diameter: json['diameter']['meters'],
      mass: json['mass']['kg'],
      active: json['active'],
      firstFlight: DateTime.parse(json['first_flight']),
      photos: json['flickr_images'],
      stages: json['stages'],
      launchCost: json['cost_per_launch'],
      successRate: json['success_rate_pct'],
      engineThrustSea: json['engines']['thrust_sea_level']['kN'],
      engineThrustVacuum: json['engines']['thrust_vacuum']['kN'],
      engineThrustToWeight: json['engines']['thrust_to_weight'],
      payloadWeights: (json['payload_weights'] as List)
          .map((payloadWeight) => PayloadWeight.fromJson(payloadWeight))
          .toList(),
      engine: '${json['engines']['type']} ${json['engines']['version']}',
      fuel: json['engines']['propellant_2'],
      oxidizer: json['engines']['propellant_1'],
      firstStage: Stage.fromJson(json['first_stage']),
      secondStage: Stage.fromJson(json['second_stage']),
      fairingDimensions: [
        json['second_stage']['payloads']['composite_fairing']['height']
            ['meters'],
        json['second_stage']['payloads']['composite_fairing']['diameter']
            ['meters'],
      ],
    );
  }

  @override
  String subtitle(BuildContext context) => firstLaunched(context);

  String getStages(BuildContext context) => FlutterI18n.translate(
        context,
        'spacex.vehicle.rocket.specifications.stages',
        {'stages': stages.toString()},
      );

  String get getLaunchCost =>
      NumberFormat.currency(symbol: "\$", decimalDigits: 0).format(launchCost);

  String getSuccessRate(BuildContext context) =>
      DateTime.now().isAfter(firstFlight)
          ? NumberFormat.percentPattern().format(successRate / 100)
          : FlutterI18n.translate(context, 'spacex.other.no_data');

  String get getEngineThrustSea =>
      '${NumberFormat.decimalPattern().format(engineThrustSea)} kN';

  String get getEngineThrustVacuum =>
      '${NumberFormat.decimalPattern().format(engineThrustVacuum)} kN';

  String getEngineThrustToWeight(BuildContext context) =>
      engineThrustToWeight == null
          ? FlutterI18n.translate(context, 'spacex.other.unknown')
          : NumberFormat.decimalPattern().format(engineThrustToWeight);

  String get getEngine => '${engine[0].toUpperCase()}${engine.substring(1)}';

  String get getFuel => '${fuel[0].toUpperCase()}${fuel.substring(1)}';

  String get getOxidizer =>
      '${oxidizer[0].toUpperCase()}${oxidizer.substring(1)}';

  String fairingHeight(BuildContext context) => fairingDimensions[0] == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : '${NumberFormat.decimalPattern().format(fairingDimensions[0])} m';

  String fairingDiameter(BuildContext context) => fairingDimensions[1] == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : '${NumberFormat.decimalPattern().format(fairingDimensions[1])} m';
}

/// PAYLOAD WEIGHT MODEL
/// Auxiliary model to storage specific orbit & payload capability.
class PayloadWeight {
  final String name;
  final int mass;

  PayloadWeight(this.name, this.mass);

  factory PayloadWeight.fromJson(Map<String, dynamic> json) {
    return PayloadWeight(json['name'], json['kg']);
  }

  String get getMass => '${NumberFormat.decimalPattern().format(mass)} kg';
}

/// STAGE MODEL
/// General information about a specific stage of a Falcon rocket.
class Stage {
  final bool reusable;
  final num engines, fuelAmount, thrust;

  Stage({
    this.reusable,
    this.engines,
    this.fuelAmount,
    this.thrust,
  });

  factory Stage.fromJson(Map<String, dynamic> json) {
    return Stage(
      reusable: json['reusable'],
      engines: json['engines'],
      fuelAmount: json['fuel_amount_tons'],
      thrust: (json['thrust_sea_level'] ?? json['thrust'])['kN'],
    );
  }

  String getEngines(BuildContext context) => FlutterI18n.translate(
        context,
        engines == 1
            ? 'spacex.vehicle.rocket.stage.engine_number'
            : 'spacex.vehicle.rocket.stage.engines_number',
        {'number': engines.toString()},
      );

  String getFuelAmount(BuildContext context) => FlutterI18n.translate(
        context,
        'spacex.vehicle.rocket.stage.fuel_amount_tons',
        {'tons': NumberFormat.decimalPattern().format(fuelAmount)},
      );

  String get getThrust => '${NumberFormat.decimalPattern().format(thrust)} kN';
}
