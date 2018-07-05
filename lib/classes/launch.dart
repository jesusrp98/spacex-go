import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'rocket.dart';

class Launch {
  final int missionNumber;
  final String missionName;
  final DateTime missionDate;
  final String missionDetails;
  final String missionLaunchSite;
  final String missionImageUrl;
  final Rocket rocket;
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
    this.rocket,
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
      rocket: Rocket.fromJson(json['rocket']),
      fairingReused: json['reuse']['fairings'],
      capsuleReused: json['reuse']['capsule'],
      linkReddit: json['links']['reddit_launch'],
      linkYouTube: json['links']['video_link'],
      linkPress: json['links']['presskit'],
    );
  }

  String getDate() {
    return "${DateFormat('dd MMMM yyyy - HH:mm').format(missionDate)}  ${missionDate.timeZoneName}";
  }

  String getImageUrl() {
    return missionImageUrl == null
        ? 'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/elon.jpg?alt=media&token=31b94ab4-3384-4908-8591-d1ba5361a1c8'
        : missionImageUrl;
  }

  String getDetails() {
    return missionDetails == null
        ? 'This mission has currently no details.'
        : missionDetails;
  }

  Rocket getRocket() {
    return rocket;
  }

  //TODO change hero image
  Widget getHeroImage(double size) {
    return Container(
      height: size,
      width: size,
      child: Hero(
        tag: missionNumber,
        child: DecoratedBox(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  fit: BoxFit.fitWidth, image: NetworkImage(getImageUrl()))),
        ),
      ),
    );
  }
}
