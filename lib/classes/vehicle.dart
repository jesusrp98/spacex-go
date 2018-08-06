import 'package:cherry/url.dart';

abstract class Vehicle {
  final String id;
  final String name;
  final String type;
  final bool active;
  final String description;

  Vehicle({
    this.id,
    this.name,
    this.type,
    this.active,
    this.description,
  });

  String get subtitle;

  String get getImageUrl => (Url.vehicleImage.containsKey(id))
      ? Url.vehicleImage[id]
      : Url.defaultImage;
}
