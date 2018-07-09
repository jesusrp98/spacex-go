class Payload {
  final String id;
  final String dragonSerial;
  final String customer;
  final String payloadType;
  final num mass;
  final String orbit;

  Payload(
      {this.id,
      this.dragonSerial,
      this.customer,
      this.payloadType,
      this.mass,
      this.orbit});

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
        id: json['payload_id'],
        dragonSerial: json['cap_serial'],
        customer: json['customers'][0],
        payloadType: json['payload_type'],
        mass: json['payload_mass_kg'],
        orbit: json['orbit']);
  }

  String getId() {
    return id == null ? 'Unknown' : id;
  }

  String getDragonSerial() {
    return dragonSerial == null ? 'Unknown' : dragonSerial;
  }

  String getCustomer() {
    return customer == null ? 'Unknown' : customer;
  }

  String getPayloadType() {
    return payloadType == null ? 'Unknown' : payloadType;
  }

  String getMass() {
    return mass == null ? 'Unknown' : '$mass kg';
  }

  String getOrbit() {
    return orbit == null ? 'Unknown' : orbit;
  }
}
