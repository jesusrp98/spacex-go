import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

import '../util/photos.dart';
import '../util/url.dart';
import 'query_model.dart';

/// SPACEX-AS-A-COMPAMY MODEL
/// General information about SpaceX's company data.
/// Used in the 'Company' tab, under the SpaceX screen.
class SpacexCompanyModel extends QueryModel {
  Company _company;

  @override
  Future loadData() async {
    // Clear old data
    clearItems();

    // Fetch & add items
    items.addAll(
      fetchData(Url.spacexAchievements)
          .map((achievement) => Achievement.fromJson(achievement))
          .toList(),
    );

    // Fetch & add item
    _company = Company.fromJson(fetchData(Url.spacexCompany));

    // Add photos & shuffle them
    if (photos.isEmpty) {
      photos.addAll(SpaceXPhotos.spacexCompanyScreen);
      photos.shuffle();
    }

    // Finished loading data
    setLoading(false);
  }

  Company get company => _company;
}

class Company {
  final String fullName, name, founder, ceo, cto, coo, city, state, details;
  final List<String> links;
  final num founded, employees, valuation;

  Company({
    this.fullName,
    this.name,
    this.founder,
    this.ceo,
    this.cto,
    this.coo,
    this.city,
    this.state,
    this.links,
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
      links: [
        json['links']['website'],
        json['links']['twitter'],
        json['links']['flickr'],
      ],
      details: json['summary'],
      founded: json['founded'],
      employees: json['employees'],
      valuation: json['valuation'],
    );
  }

  String getFounderDate(context) => FlutterI18n.translate(
        context,
        'spacex.company.founded',
        {'founded': founded.toString(), 'founder': founder},
      );

  String get getValuation =>
      NumberFormat.currency(symbol: '\$', decimalDigits: 0).format(valuation);

  String get getLocation => '$city, $state';

  String get getEmployees => NumberFormat.decimalPattern().format(employees);

  String getUrl(int index) => links[index];
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
