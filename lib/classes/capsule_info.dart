import 'package:cherry/classes/vehicle.dart';
import 'package:intl/intl.dart';

/// CAPSULE INFO CLASS
/// This class represents a model of a capsule, like Dragon1 or Crew Dragon,
/// with all its specifications.
class CapsuleInfo extends Vehicle {
  final int crew;
  final num launchMass;
  final num returnMass;
  final List<Thruster> thrusters;

  CapsuleInfo({
    id,
    name,
    type,
    active,
    height,
    diameter,
    mass,
    reusable,
    description,
    url,
    this.crew,
    this.launchMass,
    this.returnMass,
    this.thrusters,
  }) : super(
          id: id,
          name: name,
          type: type,
          active: active,
          height: height,
          diameter: diameter,
          mass: mass,
          reusable: reusable,
          description: description,
          url: url,
        );

  factory CapsuleInfo.fromJson(Map<String, dynamic> json) {
    return CapsuleInfo(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      active: json['active'],
      height: json['height_w_trunk']['meters'],
      diameter: json['diameter']['meters'],
      mass: json['dry_mass_kg'],
      reusable: true,
      description: json['description'],
      url: json['wikipedia'],
      crew: json['crew_capacity'],
      launchMass: json['launch_payload_mass']['kg'],
      returnMass: json['return_payload_mass']['kg'],
      thrusters: (json['thrusters'] as List)
          .map((thruster) => Thruster.fromJson(thruster))
          .toList(),
    );
  }

  String get subtitle =>
      crew > 0 ? 'Cargo & crew capsule' : 'Only cargo capsule';

  String get status => active ? 'Capsule in active' : 'Capsule not active';

  String get getCrew => crew == 0 ? 'No people' : '$crew people';

  String get getLaunchMass =>
      '${NumberFormat.decimalPattern().format(launchMass)} kg';

  String get getReturnMass =>
      '${NumberFormat.decimalPattern().format(returnMass)} kg';

  String get getThrusters => thrusters.length.toString();
}

class Thruster {
  final String name;
  final int amount;
  final String fuel;
  final String oxidizer;
  final num thrust;

  Thruster({
    this.name,
    this.amount,
    this.fuel,
    this.oxidizer,
    this.thrust,
  });

  factory Thruster.fromJson(Map<String, dynamic> json) {
    return Thruster(
      name: json['type'],
      amount: json['amount'],
      fuel: json['fuel_2'],
      oxidizer: json['fuel_1'],
      thrust: json['thrust']['kN'],
    );
  }

  String get getAmount => amount.toString();

  String get getFuel => '${fuel[0].toUpperCase()}${fuel.substring(1)}';

  String get getOxidizer =>
      '${oxidizer[0].toUpperCase()}${oxidizer.substring(1)}';

  String get getThrust => '${NumberFormat.decimalPattern().format(thrust)} kN';
}
