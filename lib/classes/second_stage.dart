import 'package:intl/intl.dart';

/// SECOND STAGE CLASS
/// This class is used in the Rocket class, to represent the second stage
/// of a Falcon rocket. Contains a list of the mission payload(s).
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
  final bool reused;
  final num mass;
  final String orbit;

  Payload({
    this.id,
    this.capsuleSerial,
    this.customer,
    this.nationality,
    this.manufacturer,
    this.reused,
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
      reused: json['reused'],
      mass: json['payload_mass_kg'],
      orbit: json['orbit'],
    );
  }

  String get getId => id ?? 'Unknown';

  String get getCapsuleSerial => capsuleSerial ?? 'Unknown';

  String get getCustomer => customer ?? 'Unknown';

  String get getNationality => nationality ?? 'Unknown';

  String get getManufacturer => manufacturer ?? 'Unknown';

  String get getMass => mass == null
      ? 'Unknown'
      : '${NumberFormat.decimalPattern().format(mass)} kg';

  String get getOrbit => orbit ?? 'Unknown';
}
