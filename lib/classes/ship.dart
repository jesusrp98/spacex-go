/// SHIP INFO CLASS
/// This class represents a real ship used in a SpaceX mission,
/// with all its details.
class Ship {
  final String id;
  final String name;
  final String model;
  final String type;
  final List roles;
  final bool active;
  final int weight;
  final int yearBuilt;
  final String homePort;
  final String status;
  final num speed;
  final List<double> coordinates;
  final int successfulLandings;
  final int attemptedLanding;

  Ship({
    this.id,
    this.name,
    this.model,
    this.type,
    this.roles,
    this.active,
    this.weight,
    this.yearBuilt,
    this.homePort,
    this.status,
    this.speed,
    this.coordinates,
    this.successfulLandings,
    this.attemptedLanding,
  });

  factory Ship.fromJson(Map<String, dynamic> json) {
    return Ship(
      id: json['ship_id'],
      name: json['ship_name'],
      model: json['ship_model'],
      type: json['ship_type'],
      roles: json['roles'],
      active: json['active'],
      weight: json['weight_kg'],
      yearBuilt: json['year_built'],
      homePort: json['home_port'],
      status: json['status'],
      speed: json['speed_kn'],
      coordinates: [
        json['position']['latitude'],
        json['position']['longitude'],
      ],
      successfulLandings: json['successful_landings'],
      attemptedLanding: json['attempted_landings'],
    );
  }
}
