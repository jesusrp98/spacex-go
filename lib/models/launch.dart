import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';

import '../util/index.dart';
import 'index.dart';

/// Details about a specific launch, performed by a Falcon rocket,
/// including launch & landing pads, rocket & payload information...
class Launch extends Equatable {
  final String patchUrl;
  final List<String> links;
  final List<String> photos;
  final DateTime staticFireDate;
  final bool tbd;
  final bool net;
  final int launchWindow;
  final bool success;
  final String failure;
  final String details;
  final RocketDetails rocket;
  final LaunchpadDetails launchpad;
  final int flightNumber;
  final String name;
  final DateTime launchDate;
  final String datePrecision;
  final bool upcoming;
  final String id;

  const Launch({
    this.patchUrl,
    this.links,
    this.photos,
    this.staticFireDate,
    this.tbd,
    this.net,
    this.launchWindow,
    this.success,
    this.failure,
    this.details,
    this.rocket,
    this.launchpad,
    this.flightNumber,
    this.name,
    this.launchDate,
    this.datePrecision,
    this.upcoming,
    this.id,
  });

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      patchUrl: json['links']['patch']['small'],
      links: [
        json['links']['webcast'],
        json['links']['reddit']['campaign'],
        json['links']['presskit']
      ],
      photos: (json['links']['flickr']['original'] as List).cast<String>(),
      staticFireDate: json['static_fire_date_utc'] != null
          ? DateTime.tryParse(json['static_fire_date_utc'])
          : null,
      tbd: json['tbd'],
      net: json['net'],
      launchWindow: json['window'],
      success: json['success'],
      failure: (json['failures'] as List).isNotEmpty
          ? (json['failures'] as List).first
          : null,
      details: json['details'],
      rocket: RocketDetails.fromJson(json),
      launchpad: LaunchpadDetails.fromJson(json['launchpad']),
      flightNumber: json['flight_number'],
      name: json['name'],
      launchDate:
          json['date_utc'] != null ? DateTime.tryParse(json['date_utc']) : null,
      datePrecision: json['date_precision'],
      upcoming: json['upcoming'],
      id: json['id'],
    );
  }

  int compareTo(Launch other) => flightNumber.compareTo(other.flightNumber);

  String getLaunchWindow(BuildContext context) {
    if (launchWindow == null) {
      return FlutterI18n.translate(context, 'spacex.other.unknown');
    } else if (launchWindow == 0) {
      return FlutterI18n.translate(
        context,
        'spacex.launch.page.rocket.instantaneous_window',
      );
    } else if (launchWindow < 60) {
      return '${NumberFormat.decimalPattern().format(launchWindow)} s';
    } else if (launchWindow < 3600) {
      return '${NumberFormat.decimalPattern().format(launchWindow / 60)} min';
    } else if (launchWindow % 3600 == 0) {
      return '${NumberFormat.decimalPattern().format(launchWindow / 3600)} h';
    } else {
      return '${NumberFormat.decimalPattern().format(launchWindow ~/ 3600)}h ${NumberFormat.decimalPattern().format((launchWindow / 3600 - launchWindow ~/ 3600) * 60)}min';
    }
  }

  String get getNumber => '#${NumberFormat('00').format(flightNumber)}';

  bool get hasPatch => patchUrl != null;

  bool get hasVideo => links[0] != null;

  String get getVideo => links[0];

  bool get tentativeTime => datePrecision == 'hour';

  String getDetails(BuildContext context) =>
      details ??
      FlutterI18n.translate(context, 'spacex.launch.page.no_description');

  String getLaunchDate(BuildContext context) {
    switch (datePrecision) {
      case 'hour':
        return FlutterI18n.translate(
          context,
          'spacex.other.date.time',
          translationParams: {
            'date': getTentativeDate,
            'hour': getTentativeTime
          },
        );
      default:
        return FlutterI18n.translate(
          context,
          'spacex.other.date.upcoming',
          translationParams: {'date': getTentativeDate},
        );
    }
  }

  String get getTentativeDate {
    switch (datePrecision) {
      case 'hour':
        return DateFormat.yMMMMd().format(launchDate);
      case 'day':
        return DateFormat.yMMMMd().format(launchDate);
      case 'month':
        return DateFormat.yMMMM().format(launchDate);
      case 'quarter':
        return DateFormat.yQQQ().format(launchDate);
      case 'half':
        return 'H${launchDate.month < 7 ? 1 : 2} ${launchDate.year}';
      case 'year':
        return DateFormat.y().format(launchDate);
      default:
        return 'date error';
    }
  }

  String get getShortTentativeTime => DateFormat.Hm().format(launchDate);

  String get getTentativeTime =>
      '$getShortTentativeTime ${launchDate.timeZoneName}';

  bool get isDateTooTentative =>
      datePrecision != 'hour' && datePrecision != 'day';

  String getStaticFireDate(BuildContext context) => staticFireDate == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : DateFormat.yMMMMd().format(staticFireDate);

  String get year => launchDate.year.toString();

  int getMenuIndex(BuildContext context, String url) =>
      Menu.launch.indexOf(url) + 1;

  bool isUrlEnabled(BuildContext context, String url) =>
      links[getMenuIndex(context, url)] != null;

  String getUrl(BuildContext context, String name) =>
      links[getMenuIndex(context, name)];

  bool get hasPhotos => photos.isNotEmpty;

  @override
  List<Object> get props => [
        patchUrl,
        links,
        photos,
        staticFireDate,
        tbd,
        net,
        launchWindow,
        success,
        failure,
        details,
        rocket,
        launchpad,
        flightNumber,
        name,
        launchDate,
        datePrecision,
        upcoming,
        id,
      ];
}

/// Auxiliary model to storage all details about a rocket which performed a SpaceX's mission.
class RocketDetails extends Equatable {
  final FairingsDetails fairings;
  final List<Core> cores;
  final List<Crew> crew;
  final List<Payload> payloads;
  final String name;
  final String id;

  const RocketDetails({
    this.fairings,
    this.cores,
    this.crew,
    this.payloads,
    this.name,
    this.id,
  });

  factory RocketDetails.fromJson(Map<String, dynamic> json) {
    return RocketDetails(
      fairings: json['fairings'] != null
          ? FairingsDetails.fromJson(json['fairings'])
          : null,
      cores:
          (json['cores'] as List).map((core) => Core.fromJson(core)).toList(),
      crew: (json['crew'] as List).map((crew) => Crew.fromJson(crew)).toList(),
      payloads: (json['payloads'] as List)
          .map((payload) => Payload.fromJson(payload))
          .toList(),
      name: json['rocket']['name'],
      id: json['rocket']['id'],
    );
  }

  bool get isHeavy => cores.length != 1;

  bool get hasFairings => fairings != null;

  Core get getSingleCore => cores[0];

  bool isSideCore(Core core) {
    if (id == null || !isHeavy) {
      return false;
    } else {
      return cores.indexOf(core) != 0;
    }
  }

  bool get isFirstStageNull {
    for (final core in cores) {
      if (core.id != null) return false;
    }
    return true;
  }

  bool get hasMultiplePayload => payloads.length > 1;

  Payload get getSinglePayload => payloads[0];

  bool get hasCapsule => getSinglePayload.capsule != null;

  Core getCore(String id) => cores.where((core) => core.id == id).first;

  @override
  List<Object> get props => [
        fairings,
        cores,
        crew,
        payloads,
        name,
        id,
      ];
}

/// Auxiliary model to storage details about rocket's fairings.
class FairingsDetails extends Equatable {
  final bool reused;
  final bool recoveryAttempt;
  final bool recovered;
  final List<ShipDetails> ships;

  const FairingsDetails({
    this.reused,
    this.recoveryAttempt,
    this.recovered,
    this.ships,
  });

  factory FairingsDetails.fromJson(Map<String, dynamic> json) {
    return FairingsDetails(
      reused: json['reused'],
      recoveryAttempt: json['recovery_attempt'],
      recovered: json['recovered'],
      ships: (json['ships'] as List)
          .map((ship) => ShipDetails.fromJson(ship))
          .toList(),
    );
  }

  @override
  List<Object> get props => [
        reused,
        recoveryAttempt,
        recovered,
        ships,
      ];
}

/// Auxiliary model to storage details about a core in a particular mission.
class Core extends Equatable {
  final int block;
  final int reuseCount;
  final int rtlsAttempts;
  final int rtlsLandings;
  final int asdsAttempts;
  final int asdsLandings;
  final String lastUpdate;
  final List<LaunchDetails> launches;
  final String serial;
  final String status;
  final String id;
  final String landingType;
  final bool hasGridfins;
  final bool hasLegs;
  final bool reused;
  final bool landingAttempt;
  final bool landingSuccess;
  final LandpadDetails landpad;

  const Core({
    this.block,
    this.reuseCount,
    this.rtlsAttempts,
    this.rtlsLandings,
    this.asdsAttempts,
    this.asdsLandings,
    this.lastUpdate,
    this.launches,
    this.serial,
    this.status,
    this.id,
    this.landingType,
    this.hasGridfins,
    this.hasLegs,
    this.reused,
    this.landingAttempt,
    this.landingSuccess,
    this.landpad,
  });

  factory Core.fromJson(Map<String, dynamic> json) {
    return Core(
      block: json['core'] != null ? json['core']['block'] : null,
      reuseCount: json['core'] != null ? json['core']['reuse_count'] : null,
      rtlsAttempts: json['core'] != null ? json['core']['rtls_attempts'] : null,
      rtlsLandings: json['core'] != null ? json['core']['rtls_landings'] : null,
      asdsAttempts: json['core'] != null ? json['core']['asds_attempts'] : null,
      asdsLandings: json['core'] != null ? json['core']['asds_landings'] : null,
      lastUpdate: json['core'] != null ? json['core']['last_update'] : null,
      launches: json['core'] != null
          ? (json['core']['launches'] as List)
              .map((launch) => LaunchDetails.fromJson(launch))
              .toList()
          : null,
      serial: json['core'] != null ? json['core']['serial'] : null,
      status: json['core'] != null ? json['core']['status'] : null,
      id: json['core'] != null ? json['core']['id'] : null,
      landingType: json['landing_type'],
      hasGridfins: json['gridfins'],
      hasLegs: json['legs'],
      reused: json['reused'],
      landingAttempt: json['landing_attempt'],
      landingSuccess: json['landing_success'],
      landpad: json['landpad'] != null
          ? LandpadDetails.fromJson(json['landpad'])
          : null,
    );
  }

  String get getStatus => toBeginningOfSentenceCase(status);

  String getFirstLaunched(BuildContext context) => launches.isNotEmpty
      ? DateFormat.yMMMMd().format(launches.first.date)
      : FlutterI18n.translate(context, 'spacex.other.unknown');

  String get getLaunches => launches.length.toString();

  bool get hasMissions => launches.isNotEmpty;

  String getDetails(BuildContext context) =>
      status ??
      FlutterI18n.translate(
        context,
        'spacex.dialog.vehicle.no_description_core',
      );

  String getBlock(BuildContext context) => block == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : FlutterI18n.translate(
          context,
          'spacex.other.block',
          translationParams: {'block': block.toString()},
        );

  String get getRtlsLandings => '$rtlsLandings/$rtlsAttempts';

  String get getAsdsLandings => '$asdsLandings/$asdsAttempts';

  @override
  List<Object> get props => [
        block,
        reuseCount,
        rtlsAttempts,
        rtlsLandings,
        asdsAttempts,
        asdsLandings,
        lastUpdate,
        launches,
        serial,
        status,
        id,
        hasGridfins,
        hasLegs,
        reused,
        landingAttempt,
        landingSuccess,
        landpad,
      ];
}

/// Auxiliary class to storage all details related to a member of a launch crew.
class Crew extends Equatable {
  final String name;
  final String agency;
  final String imageUrl;
  final String wikipediaUrl;
  final List<LaunchDetails> launches;
  final String status;
  final String id;

  const Crew({
    this.name,
    this.agency,
    this.imageUrl,
    this.wikipediaUrl,
    this.launches,
    this.status,
    this.id,
  });

  factory Crew.fromJson(Map<String, dynamic> json) {
    return Crew(
      name: json['name'],
      agency: json['agency'],
      imageUrl: json['image'],
      wikipediaUrl: json['wikipedia'],
      launches: (json['launches'] as List)
          .map((launch) => LaunchDetails.fromJson(launch))
          .toList(),
      status: json['status'],
      id: json['id'],
    );
  }

  @override
  List<Object> get props => [
        name,
        agency,
        imageUrl,
        wikipediaUrl,
        launches,
        status,
        id,
      ];
}

/// Specific details about an one-of-a-kink space payload.
class Payload extends Equatable {
  final CapsuleDetails capsule;
  final String name;
  final bool reused;
  final String customer;
  final String nationality;
  final String manufacturer;
  final num mass;
  final String orbit;
  final num periapsis;
  final num apoapsis;
  final num inclination;
  final num period;
  final String id;

  const Payload({
    this.capsule,
    this.name,
    this.reused,
    this.customer,
    this.nationality,
    this.manufacturer,
    this.mass,
    this.orbit,
    this.periapsis,
    this.apoapsis,
    this.inclination,
    this.period,
    this.id,
  });

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      capsule: json['dragon']['capsule'] != null
          ? CapsuleDetails.fromJson(json['dragon']['capsule'])
          : null,
      name: json['name'],
      reused: json['reused'],
      customer: (json['customers'] as List).isNotEmpty
          ? (json['customers'] as List).first
          : null,
      nationality: (json['nationalities'] as List).isNotEmpty
          ? (json['nationalities'] as List).first
          : null,
      manufacturer: (json['manufacturers'] as List).isNotEmpty
          ? (json['manufacturers'] as List).first
          : null,
      mass: json['mass_kg'],
      orbit: json['orbit'],
      periapsis: json['periapsis_km'],
      apoapsis: json['apoapsis_km'],
      inclination: json['inclination_deg'],
      period: json['period_min'],
      id: json['id'],
    );
  }

  String getName(BuildContext context) =>
      name ?? FlutterI18n.translate(context, 'spacex.other.unknown');

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

  @override
  List<Object> get props => [
        capsule,
        name,
        reused,
        customer,
        nationality,
        manufacturer,
        mass,
        orbit,
        periapsis,
        apoapsis,
        inclination,
        period,
        id,
      ];
}

/// Details about a specific launchpad, where rockets are launched from.
class LaunchpadDetails extends Equatable {
  final String name;
  final String fullName;
  final String locality;
  final String region;
  final double latitude;
  final double longitude;
  final int launchAttempts;
  final int launchSuccesses;
  final String status;
  final String details;
  final String id;

  const LaunchpadDetails({
    this.name,
    this.fullName,
    this.locality,
    this.region,
    this.latitude,
    this.longitude,
    this.launchAttempts,
    this.launchSuccesses,
    this.status,
    this.details,
    this.id,
  });

  factory LaunchpadDetails.fromJson(Map<String, dynamic> json) {
    return LaunchpadDetails(
      name: json['name'],
      fullName: json['full_name'],
      locality: json['locality'],
      region: json['region'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      launchAttempts: json['launch_attempts'],
      launchSuccesses: json['launch_successes'],
      status: json['status'],
      details: json['details'],
      id: json['id'],
    );
  }

  LatLng get coordinates => LatLng(latitude, longitude);

  String get getStatus => toBeginningOfSentenceCase(status);

  String get getCoordinates =>
      '${coordinates.latitude.toStringAsPrecision(5)},  ${coordinates.longitude.toStringAsPrecision(5)}';

  String get getSuccessfulLaunches => '$launchSuccesses/$launchAttempts';

  @override
  List<Object> get props => [
        name,
        fullName,
        locality,
        region,
        latitude,
        longitude,
        launchAttempts,
        launchSuccesses,
        id,
      ];
}

// Details about a specific capsule used in a CRS mission
class CapsuleDetails extends Equatable {
  final int reuseCount;
  final int splashings;
  final String lastUpdate;
  final List<LaunchDetails> launches;
  final String serial;
  final String status;
  final String id;

  const CapsuleDetails({
    this.reuseCount,
    this.splashings,
    this.lastUpdate,
    this.launches,
    this.serial,
    this.status,
    this.id,
  });

  factory CapsuleDetails.fromJson(Map<String, dynamic> json) {
    return CapsuleDetails(
      reuseCount: json['reuse_count'],
      splashings: json['water_landings'],
      lastUpdate: json['last_update'],
      launches: (json['launches'] as List)
          .map((launch) => LaunchDetails.fromJson(launch))
          .toList(),
      serial: json['serial'],
      status: json['status'],
      id: json['id'],
    );
  }

  String get getStatus => toBeginningOfSentenceCase(status);

  String getFirstLaunched(BuildContext context) => launches.isNotEmpty
      ? DateFormat.yMMMMd().format(launches.first.date)
      : FlutterI18n.translate(context, 'spacex.other.unknown');

  String get getLaunches => launches.length.toString();

  bool get hasMissions => launches.isNotEmpty;

  String getDetails(BuildContext context) =>
      lastUpdate ??
      FlutterI18n.translate(
        context,
        'spacex.dialog.vehicle.no_description_capsule',
      );

  String get getSplashings => splashings.toString();

  @override
  List<Object> get props => [
        reuseCount,
        splashings,
        lastUpdate,
        launches,
        serial,
        status,
        id,
      ];
}

/// Storages small details about a ship used in a specific mission.
class ShipDetails extends Equatable {
  final String name;
  final String id;

  const ShipDetails({
    this.name,
    this.id,
  });

  factory ShipDetails.fromJson(Map<String, dynamic> json) {
    return ShipDetails(
      name: json['name'],
      id: json['id'],
    );
  }

  @override
  List<Object> get props => [
        name,
        id,
      ];
}

/// Details about a specific landpad,
/// where boosters can land after completing its mission.
class LandpadDetails extends Equatable {
  final String name;
  final String fullName;
  final String type;
  final String locality;
  final String region;
  final double latitude;
  final double longitude;
  final int landingAttempts;
  final int landingSuccesses;
  final String wikipediaUrl;
  final String details;
  final String status;
  final String id;

  const LandpadDetails({
    this.name,
    this.fullName,
    this.type,
    this.locality,
    this.region,
    this.latitude,
    this.longitude,
    this.landingAttempts,
    this.landingSuccesses,
    this.wikipediaUrl,
    this.details,
    this.status,
    this.id,
  });

  factory LandpadDetails.fromJson(Map<String, dynamic> json) {
    return LandpadDetails(
      name: json['name'],
      fullName: json['full_name'],
      type: json['type'],
      locality: json['locality'],
      region: json['region'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      landingAttempts: json['landing_attempts'],
      landingSuccesses: json['landing_successes'],
      wikipediaUrl: json['wikipedia'],
      details: json['details'],
      status: json['status'],
      id: json['id'],
    );
  }

  LatLng get coordinates => LatLng(latitude, longitude);

  String get getStatus => toBeginningOfSentenceCase(status);

  String get getCoordinates =>
      '${coordinates.latitude.toStringAsPrecision(5)},  ${coordinates.longitude.toStringAsPrecision(5)}';

  String get getSuccessfulLandings => '$landingSuccesses/$landingAttempts';

  @override
  List<Object> get props => [
        name,
        fullName,
        type,
        locality,
        region,
        latitude,
        longitude,
        landingAttempts,
        landingSuccesses,
        wikipediaUrl,
        details,
        status,
        id,
      ];
}
