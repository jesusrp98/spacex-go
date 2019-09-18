import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

import '../../util/photos.dart';
import '../../util/url.dart';
import '../classes/abstract/query_model.dart';

/// General information about SpaceX's company data.
/// Used in the 'Company' tab, under the SpaceX screen.
class CompanyModel extends QueryModel {
  Company _company;

  @override
  Future loadData([BuildContext context]) async {
    if (await canLoadData()) {
      // Fetch & add items
      final List achievements = await fetchData(Url.spacexAchievements);

      // Fetch & add item
      _company = Company.fromJson(await fetchData(Url.spacexCompany));

      items.addAll(
        achievements
            .map((achievement) => Achievement.fromJson(achievement))
            .toList(),
      );

      // Add photos & shuffle them
      if (photos.isEmpty) {
        photos.addAll(SpaceXPhotos.company);
        photos.shuffle();
      }
      finishLoading();
    }
  }

  Company get company => _company;
}

class Company {
  final String fullName, name, founder, ceo, cto, coo, city, state, details;
  final num founded, employees, valuation;

  const Company({
    this.fullName,
    this.name,
    this.founder,
    this.ceo,
    this.cto,
    this.coo,
    this.city,
    this.state,
    this.details,
    this.founded,
    this.employees,
    this.valuation,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      fullName: 'Space Exploration Technologies Corporation',
      name: json['name'],
      founder: json['founder'],
      ceo: json['ceo'],
      cto: json['cto'],
      coo: json['coo'],
      city: json['headquarters']['city'],
      state: json['headquarters']['state'],
      details: json['summary'],
      founded: json['founded'],
      employees: json['employees'],
      valuation: json['valuation'],
    );
  }

  String getFounderDate(BuildContext context) => FlutterI18n.translate(
        context,
        'spacex.company.founded',
        {'founded': founded.toString(), 'founder': founder},
      );

  String get getValuation =>
      NumberFormat.currency(symbol: '\$', decimalDigits: 0).format(valuation);

  String get getLocation => '$city, $state';

  String get getEmployees => NumberFormat.decimalPattern().format(employees);
}

/// SPACEX'S ACHIEVMENT MODEL
/// Auxiliary model to storage specific SpaceX's achievments.
class Achievement {
  final String name, details, url;
  final DateTime date;

  Achievement({
    this.name,
    this.details,
    this.url,
    this.date,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      name: json['title'],
      details: json['details'],
      url: json['links']['article'],
      date: DateTime.parse(json['event_date_utc']).toLocal(),
    );
  }

  String get getDate => DateFormat.yMMMMd().format(date);
}
