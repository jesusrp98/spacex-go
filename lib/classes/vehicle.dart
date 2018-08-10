import 'package:cherry/url.dart';

/// VEHICLE CLASS
/// Abstract class that represents a real vehicle used by SpaceX. It can be
/// a rocket or a capsule, because they have similar base characteristics.
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
