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
  final String capsuleSerial;
  final String customer;
  final String nationality;
  final String manufacturer;
  final String payloadType;
  final num mass;
  final String orbit;

  Payload({
    this.id,
    this.capsuleSerial,
    this.customer,
    this.nationality,
    this.manufacturer,
    this.payloadType,
    this.mass,
    this.orbit,
  });

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      id: json['payload_id'],
      capsuleSerial: json['cap_serial'],
      customer: json['customers'][0],
      nationality: json['nationality'],
      manufacturer: json['manufacturer'],
      payloadType: json['payload_type'],
      mass: json['payload_mass_kg'],
      orbit: json['orbit'],
    );
  }

  String get getId => id ?? 'Unknown';

  String get getCapsuleSerial => capsuleSerial ?? 'Unknown';

  String get getCustomer => customer ?? 'Unknown';

  String get getNationality => nationality ?? 'Unknown';

  String get getManufacturer => manufacturer ?? 'Unknown';

  String get getPayloadType => payloadType ?? 'Unknown';

  String get getMass => mass == null
      ? 'Unknown'
      : '${NumberFormat.decimalPattern().format(mass)} kg';

  String get getOrbit => orbit ?? 'Unknown';
}
