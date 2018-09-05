import 'package:cherry/classes/rocket.dart';
import 'package:cherry/url.dart';
import 'package:intl/intl.dart';

/// LAUNCH CLASS
/// This class represent a single mission with all its details, like rocket,
/// launchpad, links...
class Launch {
  final int number;
  final String name;
  final DateTime launchDate;
  final DateTime staticFireDate;
  final String launchpadId;
  final String launchpadName;
  final String imageUrl;
  final Rocket rocket;
  final bool launchSuccess;
  final bool upcoming;
  final List<String> links;
  final String details;

  Launch({
    this.number,
    this.name,
    this.launchDate,
    this.staticFireDate,
    this.launchpadId,
    this.launchpadName,
    this.imageUrl,
    this.rocket,
    this.launchSuccess,
    this.upcoming,
    this.links,
    this.details,
  });

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      number: json['flight_number'],
      name: json['mission_name'],
      launchDate: DateTime.parse(json['launch_date_utc']).toLocal(),
      staticFireDate: setStaticFireDate(json['static_fire_date_utc']),
      launchpadId: json['launch_site']['site_id'],
      launchpadName: json['launch_site']['site_name'],
      imageUrl: json['links']['mission_patch_small'],
      rocket: Rocket.fromJson(json['rocket']),
      launchSuccess: json['launch_success'],
      upcoming: json['upcoming'],
      links: [
        json['links']['reddit_campaign'],
        json['links']['video_link'],
        json['links']['presskit'],
        json['links']['article_link'],
      ],
      details: json['details'],
    );
  }

  static DateTime setStaticFireDate(String date) {
    try {
      return DateTime.parse(date).toLocal();
    } catch (_) {
      return null;
    }
  }

  String get getNumber => '#$number';

  String get getLaunchDate =>
      DateFormat.yMMMMd().addPattern('Hm', '  ·  ').format(launchDate);

  String get getStaticFireDate => staticFireDate == null
      ? 'Unknown'
      : DateFormat.yMMMMd().format(staticFireDate);

  String get getImageUrl => imageUrl ?? Url.defaultImage;

  String get getDetails => details ?? 'This mission has currently no details.';
}
