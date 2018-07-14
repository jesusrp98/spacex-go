import 'vehicle.dart';

class DragonInfo extends Vehicle {
  final int crew;
  final num launchMass;
  final num returnMass;
  final num height;
  final num diameter;

  DragonInfo(
      {id,
      name,
      type,
      isActive,
      this.crew,
      this.launchMass,
      this.returnMass,
      this.height,
      this.diameter})
      : super(id, name, type, isActive);

  factory DragonInfo.fromJson(Map<String, dynamic> json) {
    return DragonInfo(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        isActive: json['active'],
        crew: json['crew_capacity'],
        launchMass: json['launch_payload_mass']['kg'],
        returnMass: json['return_payload_mass']['kg'],
        height: json['height_w_trunk']['meters'],
        diameter: json['diameter']['meters']);
  }

  String get getCrew => '$crew people';

  String get getLaunchMass => '$launchMass kg';

  String get getReturnMass => '$returnMass kg';

  String get getDiameter => '$diameter m';

  String get getHeight => '$height m';
}
