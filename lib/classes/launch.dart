import 'package:cherry/classes/rocket.dart';
import 'package:cherry/url.dart';
import 'package:intl/intl.dart';

/// LAUNCH CLASS
/// This class represent a single mission with all its details, like rocket,
/// launchpad, links...
class Launch {
  final int number;
  final String name, launchpadId, launchpadName, imageUrl, details;
  final List<String> links;
  final DateTime launchDate, staticFireDate;
  final bool launchSuccess, upcoming;
  final Rocket rocket;

  Launch({
    this.number,
    this.name,
    this.launchpadId,
    this.launchpadName,
    this.imageUrl,
    this.details,
    this.links,
    this.launchDate,
    this.staticFireDate,
    this.launchSuccess,
    this.upcoming,
    this.rocket,
  });

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      number: json['flight_number'],
      name: json['mission_name'],
      launchpadId: json['launch_site']['site_id'],
      launchpadName: json['launch_site']['site_name'],
      imageUrl: json['links']['mission_patch_small'],
      details: json['details'],
      links: [
        json['links']['reddit_campaign'],
        json['links']['video_link'],
        json['links']['presskit'],
        json['links']['article_link'],
      ],
      launchDate: DateTime.parse(json['launch_date_utc']).toLocal(),
      staticFireDate: setStaticFireDate(json['static_fire_date_utc']),
      launchSuccess: json['launch_success'],
      upcoming: json['upcoming'],
      rocket: Rocket.fromJson(json['rocket']),
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

  String get getImageUrl => imageUrl ?? Url.defaultImage;

  String get getDetails => details ?? 'This mission has currently no details.';

  String get getLaunchDate =>
      DateFormat.yMMMMd().addPattern('Hm', '  ·  ').format(launchDate);

  String get getStaticFireDate => staticFireDate == null
      ? 'Unknown'
      : DateFormat.yMMMMd().format(staticFireDate);
}
