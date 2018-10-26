import 'package:intl/intl.dart';

import '../url.dart';

/// VEHICLE CLASS
/// Abstract class that represents a real vehicle used by SpaceX. It can be
/// a rocket or a capsule, because they have similar base characteristics.
abstract class Vehicle {
  final String id, name, type, description, url;
  final num height, diameter, mass;
  final bool active, reusable;
  final DateTime firstFlight;
  final List photos;

  Vehicle({
    this.id,
    this.name,
    this.type,
    this.description,
    this.url,
    this.height,
    this.diameter,
    this.mass,
    this.active,
    this.reusable,
    this.firstFlight,
    this.photos,
  });

  String get subtitle;

  String get getImageUrl => (hasImages) ? photos[0] : Url.defaultImage;

  bool get hasImages => photos.isNotEmpty;

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