import 'package:cherry/utils/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// General information about SpaceX's company data.
/// Used in the 'Company' tab, under the SpaceX screen.
class CompanyInfo extends Equatable {
  final String city;
  final String state;
  final String fullName;
  final String name;
  final String founder;
  final int founded;
  final int employees;
  final String ceo;
  final String cto;
  final String coo;
  final num valuation;
  final String details;
  final String id;

  const CompanyInfo({
    required this.city,
    required this.state,
    required this.fullName,
    required this.name,
    required this.founder,
    required this.founded,
    required this.employees,
    required this.ceo,
    required this.cto,
    required this.coo,
    required this.valuation,
    required this.details,
    required this.id,
  });

  factory CompanyInfo.fromJson(Map<String, dynamic> json) {
    return CompanyInfo(
      city: (json['headquarters'] as Map)['city'],
      state: (json['headquarters'] as Map)['state'],
      fullName: 'Space Exploration Technologies Corporation',
      name: json['name'],
      founder: json['founder'],
      founded: json['founded'],
      employees: json['employees'],
      ceo: json['ceo'],
      cto: json['cto'],
      coo: json['coo'],
      valuation: json['valuation'],
      details: json['summary'],
      id: json['id'],
    );
  }

  String getFounderDate(BuildContext context) => context.translate(
        'spacex.company.founded',
        parameters: {
          'founded': founded.toString(),
          'founder': founder,
        },
      );

  String get getValuation =>
      NumberFormat.currency(symbol: '\$', decimalDigits: 0).format(valuation);

  String get getLocation => '$city, $state';

  String get getEmployees => NumberFormat.decimalPattern().format(employees);

  @override
  List<Object> get props => [
        city,
        state,
        fullName,
        name,
        founder,
        founded,
        employees,
        ceo,
        cto,
        coo,
        valuation,
        details,
        id,
      ];
}
