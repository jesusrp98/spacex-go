import 'package:flutter/material.dart';

import 'second_stage.dart';
import 'core.dart';

class Launch {
  final int missionNumber;
  final String missionName;
  final DateTime missionDate;
  final String missionDetails;
  final String missionLaunchSite;
  final String missionImageUrl;
  final String rocketName;
  final List<Core> firstStage;
  final SecondStage secondStage;
  final bool fairingReused;
  final bool capsuleReused;
  final String linkReddit;
  final String linkYouTube;
  final String linkPress;

  Launch({
    this.missionNumber,
    this.missionName,
    this.missionDate,
    this.missionDetails,
    this.missionLaunchSite,
    this.missionImageUrl,
    this.rocketName,
    this.firstStage,
    this.secondStage,
    this.fairingReused,
    this.capsuleReused,
    this.linkReddit,
    this.linkYouTube,
    this.linkPress,
  });

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      missionNumber: json['flight_number'],
      missionName: json['mission_name'],
      missionDate:
          DateTime.fromMillisecondsSinceEpoch(json['launch_date_unix'] * 1000),
      missionDetails: json['details'],
      missionLaunchSite: json['launch_site']['site_name'],
      missionImageUrl: json['links']['mission_patch_small'],
      rocketName: json['rocket']['rocket_name'],
      firstStage: (json['rocket']['first_stage']['cores'] as List)
          .map((m) => new Core.fromJson(m))
          .toList(),
      secondStage: SecondStage.fromJson(json['rocket']['second_stage']),
      fairingReused: json['reuse']['fairings'],
      capsuleReused: json['reuse']['capsule'],
      linkReddit: json['links']['reddit_launch'],
      linkYouTube: json['links']['video_link'],
      linkPress: json['links']['presskit'],
    );
  }

  Core getCore() {
    return firstStage[0];
  }

  Core getLeftBooster() {
    return firstStage[1];
  }

  Core getRightBooster() {
    return firstStage[2];
  }

  bool isCoreReused() {
    return getCore().reused;
  }

  bool isLeftBoosterReused() {
    return getLeftBooster().reused;
  }

  bool isRightBoosterReused() {
    return getRightBooster().reused;
  }

  List<Core> getFirstStage() {
    return firstStage;
  }

  bool isHeavyMission() {
    return firstStage.length != 1;
  }

  String getDate([bool utc = false]) {
    final DateTime date = utc ? missionDate.toUtc() : missionDate;
    return '${date.month}/${date.day}/${date.year - 2000}, ${date.hour}:${date.minute} ${date.timeZoneName} (UTC +${date.timeZoneOffset.inHours}h)';
  }

  String getMissionImageUrl() {
    return missionImageUrl == null
        ? 'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/elon.jpg?alt=media&token=31b94ab4-3384-4908-8591-d1ba5361a1c8'
        : missionImageUrl;
  }

  String getMissionDetails() {
    return missionDetails == null ? 'No details.' : missionDetails;
  }

  Container getHeroImage(double size, BoxShape shape) {
    return Container(
      height: size,
      width: size,
      child: Hero(
        tag: missionNumber,
        child: DecoratedBox(
          decoration: BoxDecoration(
              shape: shape,
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(getMissionImageUrl()))),
        ),
      ),
    );
  }
}
