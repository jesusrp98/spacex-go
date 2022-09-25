import 'package:cherry/models/index.dart';
import 'package:cherry/utils/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// Auxiliary model to storage details about a core in a particular mission.
class Core extends Equatable {
  final int? block;
  final int? reuseCount;
  final int? rtlsAttempts;
  final int? rtlsLandings;
  final int? asdsAttempts;
  final int? asdsLandings;
  final String? lastUpdate;
  final List<LaunchDetails> launches;
  final String? serial;
  final String? status;
  final String? id;
  final String? landingType;
  final bool? hasGridfins;
  final bool? hasLegs;
  final bool? reused;
  final bool? landingAttempt;
  final bool? landingSuccess;
  final LandpadDetails? landpad;

  const Core({
    required this.block,
    required this.reuseCount,
    required this.rtlsAttempts,
    required this.rtlsLandings,
    required this.asdsAttempts,
    required this.asdsLandings,
    required this.lastUpdate,
    required this.launches,
    required this.serial,
    required this.status,
    required this.id,
    required this.landingType,
    required this.hasGridfins,
    required this.hasLegs,
    required this.reused,
    required this.landingAttempt,
    required this.landingSuccess,
    required this.landpad,
  });

  factory Core.fromJson(Map<String, dynamic> json) {
    return Core(
      block: json['core'] != null ? (json['core'] as Map)['block'] : null,
      reuseCount:
          json['core'] != null ? (json['core'] as Map)['reuse_count'] : null,
      rtlsAttempts:
          json['core'] != null ? (json['core'] as Map)['rtls_attempts'] : null,
      rtlsLandings:
          json['core'] != null ? (json['core'] as Map)['rtls_landings'] : null,
      asdsAttempts:
          json['core'] != null ? (json['core'] as Map)['asds_attempts'] : null,
      asdsLandings:
          json['core'] != null ? (json['core'] as Map)['asds_landings'] : null,
      lastUpdate:
          json['core'] != null ? (json['core'] as Map)['last_update'] : null,
      launches: json['core'] != null
          ? ((json['core'] as Map)['launches'] as List)
              .map((launch) => LaunchDetails.fromJson(launch))
              .toList()
          : [],
      serial: json['core'] != null ? (json['core'] as Map)['serial'] : null,
      status: json['core'] != null ? (json['core'] as Map)['status'] : null,
      id: json['core'] != null ? (json['core'] as Map)['id'] : null,
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

  String get getStatus => toBeginningOfSentenceCase(status)!;

  String getFirstLaunched(BuildContext context) => launches.isNotEmpty
      ? DateFormat.yMMMMd().format(launches.first.localDate!)
      : context.translate('spacex.other.unknown');

  String get getLaunches => launches.length.toString();

  bool get hasMissions => launches.isNotEmpty;

  String getDetails(BuildContext context) =>
      lastUpdate ??
      context.translate('spacex.dialog.vehicle.no_description_core');

  String getBlock(BuildContext context) =>
      getBlockData(context) ?? context.translate('spacex.other.unknown');

  String? getBlockData(BuildContext context) => block != null
      ? context.translate(
          'spacex.other.block',
          parameters: {'block': block.toString()},
        )
      : null;

  String get getRtlsLandings => '$rtlsLandings/$rtlsAttempts';

  String get getAsdsLandings => '$asdsLandings/$asdsAttempts';

  @override
  List<Object?> get props => [
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
