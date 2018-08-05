import 'package:intl/intl.dart';

class SecondStage {
  final int block;
  final List<Payload> payloads;

  SecondStage({this.block, this.payloads});

  factory SecondStage.fromJson(Map<String, dynamic> json) {
    return SecondStage(
      block: json['block'],
      payloads: (json['payloads'] as List)
          .map((payload) => new Payload.fromJson(payload))
          .toList(),
    );
  }

  String get getBlock =>
      block == null ? 'Unknown' : 'Block ${block.toString()}';

  Payload getPayload(int index) => payloads[index];

  int get getNumberPayload => payloads.length;
}

class Payload {
  final String id;
  final String dragonSerial;
  final String customer;
  final String payloadType;
  final num mass;
  final String orbit;

  Payload({
    this.id,
    this.dragonSerial,
    this.customer,
    this.payloadType,
    this.mass,
    this.orbit,
  });

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      id: json['payload_id'],
      dragonSerial: json['cap_serial'],
      customer: json['customers'][0],
      payloadType: json['payload_type'],
      mass: json['payload_mass_kg'],
      orbit: json['orbit'],
    );
  }

  String get getId => id ?? 'Unknown';

  String get getDragonSerial => dragonSerial ?? 'Unknown';

  String get getCustomer => customer ?? 'Unknown';

  String get getPayloadType => payloadType ?? 'Unknown';

  String get getMass => mass == null
      ? 'Unknown'
      : '${NumberFormat.decimalPattern().format(mass)} kg';

  String get getOrbit => orbit ?? 'Unknown';
}

