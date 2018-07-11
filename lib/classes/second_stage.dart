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

  String getBlock() {
    return block == null ? 'Unknown' : 'Block ${block.toString()}';
  }

  Payload getPayload(int index) {
    return payloads[index];
  }

  int getNumberPayload() {
    return payloads.length;
  }

  List<Payload> getPayloads() {
    return payloads;
  }
}