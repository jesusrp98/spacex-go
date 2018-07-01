class SecondStage {
  final int block;
  final List<_Payload> payloads;

  SecondStage({this.block, this.payloads});

  factory SecondStage.fromJson(Map<String, dynamic> json) {
    return SecondStage(
      block: json['block'],
      payloads: (json['payloads'] as List)
          .map((m) => new _Payload.fromJson(m))
          .toList(),
    );
  }

  String getBlock() {
    return block == null ? 'Unknown.' : block.toString();
  }

  _Payload getPayload() {
    return payloads[0];
  }
}

class _Payload {
  final String id;
  final String customer;
  final num mass;
  final String orbit;

  _Payload({this.id, this.customer, this.mass, this.orbit});

  factory _Payload.fromJson(Map<String, dynamic> json) {
    return _Payload(
        id: json['payload_id'],
        customer: json['customers'][0],
        mass: json['payload_mass_kg'],
        orbit: json['orbit']);
  }

  String getId() {
    return id == null ? 'Unknown.' : id;
  }

  String getCustomer() {
    return customer == null ? 'Unknown.' : customer;
  }

  String getMass() {
    return mass == null ? 'Unknown.' : mass.toString();
  }

  String getOrbit() {
    return orbit == null ? 'Unknown.' : orbit;
  }
}
