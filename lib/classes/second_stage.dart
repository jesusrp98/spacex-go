import 'payload.dart';

class SecondStage {
  final int block;
  final List<Payload> payloads;

  SecondStage({this.block, this.payloads});

  factory SecondStage.fromJson(Map<String, dynamic> json) {
    return SecondStage(
      block: json['block'],
      payloads: (json['payloads'] as List)
          .map((m) => new Payload.fromJson(m))
          .toList(),
    );
  }

  String get getBlock =>
      block == null ? 'Unknown' : 'Block ${block.toString()}';

  Payload getPayload(int index) => payloads[index];

  int get getNumberPayload => payloads.length;
}
