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
  final List<String> fuels;
  final num thrust;

  Thruster({
    this.name,
    this.amount,
    this.fuels,
    this.thrust,
  });

  factory Thruster.fromJson(Map<String, dynamic> json) {
    return Thruster(
      name: json['type'],
      amount: json['amount'],
      fuels: [json['fuel_1'], json['fuel_2']],
      thrust: json['thrust']['kN'],
    );
  }

  String get getAmount => amount.toString();

  String get primaryFuel =>
      '${fuels[0][0].toUpperCase()}${fuels[0].substring(1)}';

  String get secondaryFuel =>
      '${fuels[1][0].toUpperCase()}${fuels[1].substring(1)}';

  String get getThrust => '${NumberFormat.decimalPattern().format(thrust)} kN';
}
