import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

/// Auxiliary model to storage all details about a rocket which performed a SpaceX's mission.
class Rocket {
  final String id, name;
  final List<Core> firstStage;
  final SecondStage secondStage;
  final Fairing fairing;

  const Rocket({
    this.id,
    this.name,
    this.firstStage,
    this.secondStage,
    this.fairing,
  });

  factory Rocket.fromJson(Map<String, dynamic> json) {
    return Rocket(
      id: json['rocket_id'],
      name: json['rocket_name'],
      firstStage: (json['first_stage']['cores'] as List)
          .map((core) => Core.fromJson(core))
          .toList(),
      secondStage: SecondStage.fromJson(json['second_stage']),
      fairing:
          json['fairings'] == null ? null : Fairing.fromJson(json['fairings']),
    );
  }

  bool get isHeavy => firstStage.length != 1;

  bool get hasFairing => fairing != null;

  Core get getSingleCore => firstStage[0];

  bool isSideCore(Core core) {
    if (id == null || !isHeavy) {
      return false;
    } else {
      return firstStage.indexOf(core) != 0;
    }

  }

  bool get isFirstStageNull {
    for (final Core core in firstStage) {
      if (core.id != null) return false;
    }
    return true;
  }
}

/// CORE CLASS
/// Auxiliary model to storage details about a core in a particular mission.
class Core {
  final String id, landingType, landingZone;
  final bool reused, landingSuccess, landingIntent, gridfins, legs;
  final int block, flights;

  Core({
    this.id,
    this.landingType,
    this.landingZone,
    this.reused,
    this.landingSuccess,
    this.landingIntent,
    this.gridfins,
    this.legs,
    this.block,
    this.flights,
  });

  factory Core.fromJson(Map<String, dynamic> json) {
    return Core(
      id: json['core_serial'],
      landingType: json['landing_type'],
      landingZone: json['landing_vehicle'],
      reused: json['reused'],
      landingSuccess: json['land_success'],
      landingIntent: json['landing_intent'],
      gridfins: json['gridfins'],
      legs: json['legs'],
      block: json['block'],
      flights: json['flight'],
    );
  }

  String getId(BuildContext context) =>
      id ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getLandingType(BuildContext context) =>
      landingType ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getLandingZone(BuildContext context) =>
      landingZone ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getBlock(BuildContext context) => block == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : FlutterI18n.translate(
          context,
          'spacex.other.block',
          {'block': block.toString()},
        );

  String getFlights(BuildContext context) => flights == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : flights.toString();
}

/// SECOND STAGE MODEL
/// Details about rocket's second stage.
class SecondStage {
  final int block;
  final List<Payload> payloads;

  SecondStage({this.block, this.payloads});

  factory SecondStage.fromJson(Map<String, dynamic> json) {
    return SecondStage(
      block: json['block'],
      payloads: (json['payloads'] as List)
          .map((payload) => Payload.fromJson(payload))
          .toList(),
    );
  }

  String getBlock(BuildContext context) => block == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : FlutterI18n.translate(
          context,
          'spacex.other.block',
          {'block': block.toString()},
        );

  Payload getPayload(int index) => payloads[index];

  int get getNumberPayload => payloads.length;
}

/// PAYLOAD MODEL
/// Specific details about an one-of-a-kink space payload.
class Payload {
  final String id, capsuleSerial, customer, nationality, manufacturer, orbit;
  final bool reused;
  final num mass, periapsis, apoapsis, inclination, period;

  Payload({
    this.id,
    this.capsuleSerial,
    this.customer,
    this.nationality,
    this.manufacturer,
    this.orbit,
    this.reused,
    this.mass,
    this.periapsis,
    this.apoapsis,
    this.inclination,
    this.period,
  });

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      id: json['payload_id'],
      capsuleSerial: json['cap_serial'],
      customer: json['customers'].isNotEmpty ? json['customers'][0] : null,
      nationality: json['nationality'],
      manufacturer: json['manufacturer'],
      orbit: json['orbit'],
      reused: json['reused'],
      mass: json['payload_mass_kg'],
      periapsis: json['orbit_params']['periapsis_km'],
      apoapsis: json['orbit_params']['apoapsis_km'],
      inclination: json['orbit_params']['inclination_deg'],
      period: json['orbit_params']['period_min'],
    );
  }

  String getId(BuildContext context) =>
      id ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getCapsuleSerial(BuildContext context) =>
      capsuleSerial ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getCustomer(BuildContext context) =>
      customer ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getNationality(BuildContext context) =>
      nationality ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getManufacturer(BuildContext context) =>
      manufacturer ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getOrbit(BuildContext context) =>
      orbit ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getMass(BuildContext context) => mass == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : '${NumberFormat.decimalPattern().format(mass)} kg';

  String getPeriapsis(BuildContext context) => periapsis == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : '${NumberFormat.decimalPattern().format(periapsis.round())} km';

  String getApoapsis(BuildContext context) => apoapsis == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : '${NumberFormat.decimalPattern().format(apoapsis.round())} km';

  String getInclination(BuildContext context) => inclination == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : '${NumberFormat.decimalPattern().format(inclination.round())}°';

  String getPeriod(BuildContext context) => period == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : '${NumberFormat.decimalPattern().format(period.round())} min';

  bool get isNasaPayload =>
      customer == 'NASA (CCtCap)' ||
      customer == 'NASA (CRS)' ||
      customer == 'NASA(COTS)';
}

/// FAIRING MODEL
/// Auxiliary model to storage details about rocket's fairings.
class Fairing {
  final bool reused, recoveryAttempt, recoverySuccess;
  final String ship;

  Fairing({
    this.reused,
    this.recoveryAttempt,
    this.recoverySuccess,
    this.ship,
  });

  factory Fairing.fromJson(Map<String, dynamic> json) {
    return Fairing(
      reused: json['reused'],
      recoveryAttempt: json['recovery_attempt'],
      recoverySuccess: json['recovered'],
      ship: json['ship'],
    );
  }
}
