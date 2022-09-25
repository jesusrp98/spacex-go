import 'package:cherry/models/index.dart';
import 'package:cherry/utils/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

// Details about a specific capsule used in a CRS mission
class CapsuleDetails extends Equatable {
  final int reuseCount;
  final int splashings;
  final String? lastUpdate;
  final List<LaunchDetails> launches;
  final String serial;
  final String status;
  final String type;
  final String id;

  const CapsuleDetails({
    required this.reuseCount,
    required this.splashings,
    required this.lastUpdate,
    required this.launches,
    required this.serial,
    required this.status,
    required this.type,
    required this.id,
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
      type: json['type'],
      id: json['id'],
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
      context.translate('spacex.dialog.vehicle.no_description_capsule');

  String get getSplashings => splashings.toString();

  @override
  List<Object?> get props => [
        reuseCount,
        splashings,
        lastUpdate,
        launches,
        serial,
        status,
        type,
        id,
      ];
}
