import 'package:cherry/url.dart';
import 'package:intl/intl.dart';

/// VEHICLE CLASS
/// Abstract class that represents a real vehicle used by SpaceX. It can be
/// a rocket or a capsule, because they have similar base characteristics.
abstract class Vehicle {
  final String id, name, type, details, url;
  final num height, diameter, mass;
  final bool active, reusable;
  final DateTime firstFlight;

  Vehicle({
    this.id,
    this.name,
    this.type,
    this.details,
    this.url,
    this.height,
    this.diameter,
    this.mass,
    this.active,
    this.reusable,
    this.firstFlight,
  });

  String get subtitle;

  String get getImageUrl => (Url.vehicleImage.containsKey(id))
      ? Url.vehicleImage[id]
      : Url.defaultImage;

  String get getHeight => '${NumberFormat.decimalPattern().format(height)} m';

  String get getDiameter =>
      '${NumberFormat.decimalPattern().format(diameter)} m';

  String get getMass => mass == null
      ? 'Unknown'
      : '${NumberFormat.decimalPattern().format(mass)} kg';

  String get getFirstFlight => DateFormat.yMMMM().format(firstFlight);

  String get firstLaunched {
    if (!DateTime.now().isAfter(firstFlight))
      return 'Scheduled to $getFirstFlight';
    else
      return 'First launched on $getFirstFlight';
  }
}
