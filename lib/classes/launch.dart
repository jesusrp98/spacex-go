import 'package:cherry/classes/rocket.dart';
import 'package:intl/intl.dart';

class Launch {
  final int number;
  final String name;
  final DateTime date;
  final String launchpadId;
  final String launchpadName;
  final String imageUrl;
  final Rocket rocket;
  final bool launchSuccess;
  final bool fairingReused;
  final bool capsuleReused;
  final List<String> links;
  final String details;

  Launch({
    this.number,
    this.name,
    this.date,
    this.launchpadId,
    this.launchpadName,
    this.imageUrl,
    this.rocket,
    this.launchSuccess,
    this.fairingReused,
    this.capsuleReused,
    this.links,
    this.details,
  });

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      number: json['flight_number'],
      name: json['mission_name'],
      date: DateTime.fromMillisecondsSinceEpoch(
        json['launch_date_unix'] * 1000,
      ),
      launchpadId: json['launch_site']['site_id'],
      launchpadName: json['launch_site']['site_name'],
      imageUrl: json['links']['mission_patch_small'],
      rocket: Rocket.fromJson(json['rocket']),
      launchSuccess: json['launch_success'],
      fairingReused: json['reuse']['fairings'],
      capsuleReused: json['reuse']['capsule'],
      links: [
        json['links']['reddit_campaign'],
        json['links']['video_link'],
        json['links']['presskit'],
        json['links']['article_link'],
      ],
      details: json['details'],
    );
  }

  String get getNumber => '#$number';

  String get getDate =>
      '${DateFormat('d MMMM yyyy · HH:mm').format(date)} ${date.timeZoneName}';

  String get getImageUrl =>
      imageUrl ??
      'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/rocket.png?alt=media&token=66f2dde6-e6ff-4f64-a4a4-9fab6dbe90c5';

  String get getDetails => details ?? 'This mission has currently no details.';
}
