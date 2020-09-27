import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

/// Auxiliary model to storage specific SpaceX's achievments.
class Achievement extends Equatable {
  final String id, name, details, url;
  final DateTime date;

  const Achievement({
    this.id,
    this.name,
    this.details,
    this.url,
    this.date,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'],
      name: json['title'],
      details: json['details'],
      url: json['links']['article'],
      date: DateTime.parse(json['event_date_utc']),
    );
  }

  String get getDate => DateFormat.yMMMMd().format(date);

  bool get hasLink => url != null;

  @override
  List<Object> get props => [
        id,
        name,
        details,
        url,
        date,
      ];
}
