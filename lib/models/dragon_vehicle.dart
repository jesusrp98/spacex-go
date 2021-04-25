import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../utils/index.dart';
import 'index.dart';

/// General information about a Dragon capsule.
class DragonVehicle extends Vehicle {
  final num crew, launchMass, returnMass;
  final List<Thruster> thrusters;
  final bool reusable;

  const DragonVehicle({
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
    this.crew,
    this.launchMass,
    this.returnMass,
    this.thrusters,
    this.reusable,
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

  factory DragonVehicle.fromJson(Map<String, dynamic> json) {
    return DragonVehicle(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      description: json['description'],
      url: json['wikipedia'],
      height: json['height_w_trunk']['meters'],
      diameter: json['diameter']['meters'],
      mass: json['dry_mass_kg'],
      active: json['active'],
      firstFlight: DateTime.parse(json['first_flight']),
      photos: json['flickr_images'].cast<String>(),
      crew: json['crew_capacity'],
      launchMass: json['launch_payload_mass']['kg'],
      returnMass: json['return_payload_mass']['kg'],
      thrusters: [
        for (final item in json['thrusters']) Thruster.fromJson(item)
      ],
      reusable: true,
    );
  }

  @override
  String subtitle(BuildContext context) => firstLaunched(context);

  bool get isCrewEnabled => crew != 0;

  String getCrew(BuildContext context) => isCrewEnabled
      ? context.translate(
          'spacex.vehicle.capsule.description.people',
          parameters: {'people': crew.toString()},
        )
      : context.translate('spacex.vehicle.capsule.description.no_people');

  String get getLaunchMass =>
      '${NumberFormat.decimalPattern().format(launchMass)} kg';

  String get getReturnMass =>
      '${NumberFormat.decimalPattern().format(returnMass)} kg';

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
        crew,
        launchMass,
        returnMass,
        thrusters,
        reusable,
      ];
}

/// Auxiliar model used to storage Dragon's thrusters data.
class Thruster extends Equatable {
  final String model;
  final String fuel;
  final String oxidizer;
  final num amount;
  final num thrust;
  final num isp;

  const Thruster({
    this.model,
    this.fuel,
    this.oxidizer,
    this.amount,
    this.thrust,
    this.isp,
  });

  factory Thruster.fromJson(Map<String, dynamic> json) {
    return Thruster(
      model: json['type'],
      fuel: json['fuel_2'],
      oxidizer: json['fuel_1'],
      amount: json['amount'],
      thrust: json['thrust']['kN'],
      isp: json['isp'],
    );
  }

  String get getFuel => toBeginningOfSentenceCase(fuel);

  String get getOxidizer => toBeginningOfSentenceCase(oxidizer);

  String get getAmount => amount.toString();

  String get getThrust => '${NumberFormat.decimalPattern().format(thrust)} kN';

  String get getIsp => '${NumberFormat.decimalPattern().format(isp)} s';

  @override
  List<Object> get props => [
        model,
        fuel,
        oxidizer,
        amount,
        thrust,
        isp,
      ];
}
