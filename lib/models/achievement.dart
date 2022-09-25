import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

/// Auxiliary model to storage specific SpaceX's achievments.
class Achievement extends Equatable {
  final String id;
  final String title;
  final DateTime date;
  final String details;
  final String? url;

  const Achievement({
    required this.id,
    required this.title,
    required this.date,
    required this.details,
    required this.url,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'],
      title: json['title'],
      details: json['details'],
      url: (json['links'] as Map)['article'],
      date: DateTime.parse(json['event_date_utc']),
    );
  }

  String get getDate => DateFormat.yMMMMd().format(date);

  bool get hasLink => url != null;

  @override
  List<Object?> get props => [
        id,
        title,
        details,
        url,
        date,
      ];
}
