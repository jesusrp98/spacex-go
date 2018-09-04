import 'package:cherry/url.dart';
import 'package:intl/intl.dart';

/// VEHICLE CLASS
/// Abstract class that represents a real vehicle used by SpaceX. It can be
/// a rocket or a capsule, because they have similar base characteristics.
abstract class Vehicle {
  final String id;
  final String name;
  final String type;
  final bool active;
  final DateTime firstFlight;
  final num height;
  final num diameter;
  final num mass;
  final bool reusable;
  final String description;
  final String url;

  Vehicle({
    this.id,
    this.name,
    this.type,
    this.active,
    this.firstFlight,
    this.height,
    this.diameter,
    this.mass,
    this.reusable,
    this.description,
    this.url,
  });

  String get subtitle;

  String get getFirstFlight => DateFormat.yMMMM().format(firstFlight);

  String get firstLaunched {
    if (!DateTime.now().isAfter(firstFlight))
      return 'Scheduled to $getFirstFlight';
    else
      return 'First launched on $getFirstFlight';
  }

  String get getHeight => '${NumberFormat.decimalPattern().format(height)} m';

  String get getDiameter =>
      '${NumberFormat.decimalPattern().format(diameter)} m';

  String get getMass => '${NumberFormat.decimalPattern().format(mass)} kg';

  String get getImageUrl => (Url.vehicleImage.containsKey(id))
      ? Url.vehicleImage[id]
      : Url.defaultImage;
}
