import 'core.dart';
import 'second_stage.dart';

class Launch {
  final int missionNumber;
  final String missionName;
  final String missionDate;
  final String missionDetails;
  final String missionImage;
  final String rocketName;
  final List<Core> firstStage;
  final SecondStage secondStage;
  final String siteName;
  final String linkReddit;
  final String linkYouTube;
  final String linkPress;

  Launch({
    this.missionNumber,
    this.missionName,
    this.missionDate,
    this.missionDetails,
    this.missionImage,
    this.rocketName,
    this.firstStage,
    this.secondStage,
    this.siteName,
    this.linkReddit,
    this.linkYouTube,
    this.linkPress,
  });

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      missionNumber: json['flight_number'],
      missionName: json['mission_name'],
      missionDate: json['launch_date_utc'],
      missionDetails: json['details'],
      missionImage: json['links']['mission_patch_small'],
      rocketName: json['rocket']['rocket_name'],
      firstStage: (json['rocket']['first_stage']['cores'] as List)
          .map((m) => new Core.fromJson(m))
          .toList(),
      secondStage: SecondStage.fromJson(json['rocket']['second_stage']),
      siteName: json['launch_site']['site_name'],
      linkReddit: json['links']['reddit_launch'],
      linkYouTube: json['links']['video_link'],
      linkPress: json['links']['presskit'],
    );
  }
}
