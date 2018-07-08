class DragonInfo {
  final String name;
  final bool isActive;
  final int crew;
  final num launchMass;
  final num returnMass;
  final num diameter;

  DragonInfo(
      {this.name,
      this.isActive,
      this.crew,
      this.launchMass,
      this.returnMass,
      this.diameter});

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
