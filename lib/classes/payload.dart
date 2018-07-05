class Payload {
  final String id;
  final String customer;
  final num mass;
  final String orbit;

  Payload({this.id, this.customer, this.mass, this.orbit});

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
        id: json['payload_id'],
        customer: json['customers'][0],
        mass: json['payload_mass_kg'],
        orbit: json['orbit']);
  }

  String getId() {
    return id == null ? 'Unknown' : id;
  }

  String getCustomer() {
    return customer == null ? 'Unknown' : customer;
  }

  String getMass() {
    return mass == null ? 'Unknown' : '$mass kg';
  }

  String getOrbit() {
    return orbit == null ? 'Unknown' : orbit;
  }
}