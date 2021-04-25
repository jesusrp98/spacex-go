import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../utils/index.dart';
import 'index.dart';

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
      name ?? context.translate('spacex.other.unknown');

  String getCustomer(BuildContext context) =>
      customer ?? context.translate('spacex.other.unknown');

  String getNationality(BuildContext context) =>
      nationality ?? context.translate('spacex.other.unknown');

  String getManufacturer(BuildContext context) =>
      manufacturer ?? context.translate('spacex.other.unknown');

  String getOrbit(BuildContext context) =>
      orbit ?? context.translate('spacex.other.unknown');

  String getMass(BuildContext context) => mass == null
      ? context.translate('spacex.other.unknown')
      : '${NumberFormat.decimalPattern().format(mass)} kg';

  String getPeriapsis(BuildContext context) => periapsis == null
      ? context.translate('spacex.other.unknown')
      : '${NumberFormat.decimalPattern().format(periapsis.round())} km';

  String getApoapsis(BuildContext context) => apoapsis == null
      ? context.translate('spacex.other.unknown')
      : '${NumberFormat.decimalPattern().format(apoapsis.round())} km';

  String getInclination(BuildContext context) => inclination == null
      ? context.translate('spacex.other.unknown')
      : '${NumberFormat.decimalPattern().format(inclination.round())}°';

  String getPeriod(BuildContext context) => period == null
      ? context.translate('spacex.other.unknown')
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
