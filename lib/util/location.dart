import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<tz.Location> getUserLocation() async {
  tz.initializeTimeZones();
  return tz.getLocation(await FlutterNativeTimezone.getLocalTimezone());
}
