import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../utils/index.dart';
import 'index.dart';

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
      ? DateFormat.yMMMMd().format(launches.first.localDate)
      : context.translate('spacex.other.unknown');

  String get getLaunches => launches.length.toString();

  bool get hasMissions => launches.isNotEmpty;

  String getDetails(BuildContext context) =>
      lastUpdate ??
      context.translate('spacex.dialog.vehicle.no_description_core');

  String getBlock(BuildContext context) =>
      getBlockData(context) ?? context.translate('spacex.other.unknown');

  String getBlockData(BuildContext context) => block != null
      ? context.translate(
          'spacex.other.block',
          parameters: {'block': block.toString()},
        )
      : null;

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
