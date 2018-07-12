import 'vehicle.dart';

class DragonInfo extends Vehicle {
  final int crew;
  final num launchMass;
  final num returnMass;
  final num diameter;

  DragonInfo(
      {id,
      name,
      type,
      isActive,
      this.crew,
      this.launchMass,
      this.returnMass,
      this.diameter})
      : super(id, name, type, isActive);

  factory DragonInfo.fromJson(Map<String, dynamic> json) {
    return DragonInfo(
        name: json['name'],
        isActive: json['active'],
        crew: json['crew_capacity'],
        launchMass: json['launch_payload_mass']['kg'],
        returnMass: json['return_payload_mass']['kg'],
        diameter: json['diameter']['meters']);
  }
}
