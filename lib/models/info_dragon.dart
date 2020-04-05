import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

import 'info_vehicle.dart';

/// General information about a Dragon capsule.
class DragonInfo extends VehicleInfo {
  final num crew, launchMass, returnMass;
  final List<Thruster> thrusters;
  final bool reusable;

  const DragonInfo({
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

  factory DragonInfo.fromJson(Map<String, dynamic> json) {
    return DragonInfo(
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
      ? FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.description.people',
          translationParams: {'people': crew.toString()},
        )
      : FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.description.no_people',
        );

  String get getLaunchMass =>
      '${NumberFormat.decimalPattern().format(launchMass)} kg';

  String get getReturnMass =>
      '${NumberFormat.decimalPattern().format(returnMass)} kg';
}

/// Auxiliar model used to storage Dragon's thrusters data.
class Thruster {
  final String model, fuel, oxidizer;
  final num amount, thrust, isp;

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
}
