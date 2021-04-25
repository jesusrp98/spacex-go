import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../utils/index.dart';
import 'index.dart';

/// General information about a Falcon rocket.
class RocketVehicle extends Vehicle {
  final num stages, launchCost, successRate;
  final List<PayloadWeight> payloadWeights;
  final Engine engine;
  final Stage firstStage, secondStage;
  final List<double> fairingDimensions;

  const RocketVehicle({
    String id,
    String name,
    String type,
    String description,
    String url,
    num height,
    num diameter,
    num mass,
    bool active,
    DateTime firstFlight,
    List<String> photos,
    this.stages,
    this.launchCost,
    this.successRate,
    this.payloadWeights,
    this.engine,
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

  factory RocketVehicle.fromJson(Map<String, dynamic> json) {
    return RocketVehicle(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      description: json['description'],
      url: json['wikipedia'],
      height: json['height']['meters'],
      diameter: json['diameter']['meters'],
      mass: json['mass']['kg'],
      active: json['active'],
      firstFlight: DateTime.parse(json['first_flight']),
      photos: json['flickr_images'].cast<String>(),
      stages: json['stages'],
      launchCost: json['cost_per_launch'],
      successRate: json['success_rate_pct'],
      payloadWeights: [
        for (final payloadWeight in json['payload_weights'])
          PayloadWeight.fromJson(payloadWeight)
      ],
      engine: Engine.fromJson(json['engines']),
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

  String getStages(BuildContext context) => context.translate(
        'spacex.vehicle.rocket.specifications.stages',
        parameters: {'stages': stages.toString()},
      );

  String get getLaunchCost =>
      NumberFormat.currency(symbol: "\$", decimalDigits: 0).format(launchCost);

  String getSuccessRate(BuildContext context) =>
      DateTime.now().isAfter(firstFlight)
          ? NumberFormat.percentPattern().format(successRate / 100)
          : context.translate('spacex.other.no_data');

  String fairingHeight(BuildContext context) => fairingDimensions[0] == null
      ? context.translate('spacex.other.unknown')
      : '${NumberFormat.decimalPattern().format(fairingDimensions[0])} m';

  String fairingDiameter(BuildContext context) => fairingDimensions[1] == null
      ? context.translate('spacex.other.unknown')
      : '${NumberFormat.decimalPattern().format(fairingDimensions[1])} m';

  @override
  List<Object> get props => [
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
        stages,
        launchCost,
        successRate,
        payloadWeights,
        engine,
        firstStage,
        secondStage,
        fairingDimensions,
      ];
}

/// Auxiliar model used to storage rocket's engine data.
class Engine extends Equatable {
  final num thrustSea;
  final num thrustVacuum;
  final num thrustToWeight;
  final num ispSea;
  final num ispVacuum;
  final String name;
  final String fuel;
  final String oxidizer;

  const Engine({
    this.thrustSea,
    this.thrustVacuum,
    this.thrustToWeight,
    this.ispSea,
    this.ispVacuum,
    this.name,
    this.fuel,
    this.oxidizer,
  });

  factory Engine.fromJson(Map<String, dynamic> json) {
    return Engine(
      thrustSea: json['thrust_sea_level']['kN'],
      thrustVacuum: json['thrust_vacuum']['kN'],
      thrustToWeight: json['thrust_to_weight'],
      ispSea: json['isp']['sea_level'],
      ispVacuum: json['isp']['vacuum'],
      name: '${json['type']} ${json['version']}',
      fuel: json['propellant_2'],
      oxidizer: json['propellant_1'],
    );
  }

  String get getThrustSea =>
      '${NumberFormat.decimalPattern().format(thrustSea)} kN';

  String get getThrustVacuum =>
      '${NumberFormat.decimalPattern().format(thrustVacuum)} kN';

  String getThrustToWeight(BuildContext context) => thrustToWeight == null
      ? context.translate('spacex.other.unknown')
      : NumberFormat.decimalPattern().format(thrustToWeight);

  String get getIspSea => '${NumberFormat.decimalPattern().format(ispSea)} s';

  String get getIspVacuum =>
      '${NumberFormat.decimalPattern().format(ispVacuum)} s';

  String get getName => toBeginningOfSentenceCase(name);

  String get getFuel => toBeginningOfSentenceCase(fuel);

  String get getOxidizer => toBeginningOfSentenceCase(oxidizer);

  @override
  List<Object> get props => [
        thrustSea,
        thrustVacuum,
        thrustToWeight,
        ispSea,
        ispVacuum,
        name,
        fuel,
        oxidizer,
      ];
}

/// Auxiliary model to storage specific orbit & payload capability.
class PayloadWeight extends Equatable {
  final String name;
  final int mass;

  const PayloadWeight(this.name, this.mass);

  factory PayloadWeight.fromJson(Map<String, dynamic> json) {
    return PayloadWeight(json['name'], json['kg']);
  }

  String get getMass => '${NumberFormat.decimalPattern().format(mass)} kg';

  @override
  List<Object> get props => [
        name,
        mass,
      ];
}

/// General information about a specific stage of a Falcon rocket.
class Stage extends Equatable {
  final bool reusable;
  final num engines;
  final num fuelAmount;
  final num thrust;

  const Stage({
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

  String getEngines(BuildContext context) => context.translate(
        engines == 1
            ? 'spacex.vehicle.rocket.stage.engine_number'
            : 'spacex.vehicle.rocket.stage.engines_number',
        parameters: {'number': engines.toString()},
      );

  String getFuelAmount(BuildContext context) => context.translate(
        'spacex.vehicle.rocket.stage.fuel_amount_tons',
        parameters: {'tons': NumberFormat.decimalPattern().format(fuelAmount)},
      );

  String get getThrust => '${NumberFormat.decimalPattern().format(thrust)} kN';

  @override
  List<Object> get props => [
        reusable,
        engines,
        fuelAmount,
        thrust,
      ];
}
