import 'package:cherry/classes/vehicle.dart';
import 'package:intl/intl.dart';

class CapsuleInfo extends Vehicle {
  final int crew;
  final num launchMass;
  final num returnMass;
  final List<Thruster> thrusters;
  final num height;
  final num diameter;

  CapsuleInfo({
    id,
    name,
    type,
    active,
    description,
    this.crew,
    this.launchMass,
    this.returnMass,
    this.thrusters,
    this.height,
    this.diameter,
  }) : super(
          id: id,
          name: name,
          type: type,
          active: active,
          description: description,
        );

  factory CapsuleInfo.fromJson(Map<String, dynamic> json) {
    return CapsuleInfo(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      active: json['active'],
      description: json['description'],
      crew: json['crew_capacity'],
      launchMass: json['launch_payload_mass']['kg'],
      returnMass: json['return_payload_mass']['kg'],
      thrusters: (json['thrusters'] as List)
          .map((thruster) => Thruster.fromJson(thruster))
          .toList(),
      height: json['height_w_trunk']['meters'],
      diameter: json['diameter']['meters'],
    );
  }

  String get subtitle =>
      crew > 0 ? 'Cargo & crew capsule' : 'Only cargo capsule';

  String get status => active ? 'Capsule active' : 'Capsule not active';

  String get getCrew => crew == 0 ? 'No people' : '$crew people';

  String get getLaunchMass =>
      '${NumberFormat.decimalPattern().format(launchMass)} kg';

  String get getReturnMass =>
      '${NumberFormat.decimalPattern().format(returnMass)} kg';

  String get getThrusters => thrusters.length.toString();

  String get getHeight => '${NumberFormat.decimalPattern().format(height)} m';

  String get getDiameter =>
      '${NumberFormat.decimalPattern().format(diameter)} m';
}

class Thruster {
  final String name;
  final int amount;
  final int pods;
  final List<String> fuels;
  final num thrust;

  Thruster({
    this.name,
    this.amount,
    this.pods,
    this.fuels,
    this.thrust,
  });

  factory Thruster.fromJson(Map<String, dynamic> json) {
    return Thruster(
      name: json['type'],
      amount: json['amount'],
      pods: json['pods'],
      fuels: [
        json['fuel_1'],
        json['fuel_2'],
      ],
      thrust: json['thrust']['kN'],
    );
  }

  String get getAmount => amount.toString();

  String get getPods => pods.toString();

  String get primaryFuel =>
      '${fuels[0][0].toUpperCase()}${fuels[0].substring(1)}';

  String get secondaryFuel =>
      '${fuels[1][0].toUpperCase()}${fuels[1].substring(1)}';

  String get getThrust => '${NumberFormat.decimalPattern().format(thrust)} kN';
}
