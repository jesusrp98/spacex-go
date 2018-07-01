import 'package:flutter/material.dart';

import 'second_stage.dart';
import 'core.dart';

class Launch {
  final int missionNumber;
  final String missionName;
  final DateTime missionDate;
  final String missionDetails;
  final String missionImage;
  final String rocketName;
  final List<Core> firstStage;
  final SecondStage secondStage;
  final bool fairingReused;
  final bool capsuleReused;
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
    this.fairingReused,
    this.capsuleReused,
    this.siteName,
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
      missionImage: json['links']['mission_patch_small'],
      rocketName: json['rocket']['rocket_name'],
      firstStage: (json['rocket']['first_stage']['cores'] as List)
          .map((m) => new Core.fromJson(m))
          .toList(),
      secondStage: SecondStage.fromJson(json['rocket']['second_stage']),
      fairingReused: json['reuse']['fairings'],
      capsuleReused: json['reuse']['capsule'],
      siteName: json['launch_site']['site_name'],
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

  bool isHeavy() {
    return firstStage.length != 1;
  }

  String getDateLocal() {
    return '${missionDate.month}/${missionDate.day}/${missionDate.year - 2000}, ${missionDate.hour}:${missionDate.minute}';
  }

  Image getImage() {
    return missionImage == null ? Image.asset('assets/stock.jpg') : Image.network(missionImage);
  }

  String getDetails() {
    return missionDetails == null ? 'No details.' : missionDetails;
  }
}
