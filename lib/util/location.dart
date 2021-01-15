import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;

Future<tz.Location> getUserLocation() async =>
    tz.getLocation(await FlutterNativeTimezone.getLocalTimezone());
