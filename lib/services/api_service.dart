import 'package:cherry/repositories/launches.dart';
import 'package:dio/dio.dart';

import '../util/url.dart';

class ApiService {
  static Future<Response> getChangelog() async {
    return Dio().get(Url.changelog);
  }

  static Future<Response> getAchievements() async {
    return Dio().get(Url.companychievements);
  }

  static Future<Response> getCompanyInformation() async {
    return Dio().get(Url.companyInformation);
  }

  static Future<Response> getCapsule(String id) async {
    return Dio().get(Url.capsule + id);
  }

  static Future<Response> getCore(String id) async {
    return Dio().get(Url.core + id);
  }

  static Future<Response> getLaunches(LaunchType type) async {
    return Dio().get(
      type == LaunchType.upcoming ? Url.upcomingLaunches : Url.latestLaunches,
    );
  }

  static Future<Response> getNextLaunch() async {
    return Dio().get(Url.nextLaunch);
  }

  static Future<Response> getRoadster() async {
    return Dio().get(Url.roadster);
  }

  static Future<Response> getDragons() async {
    return Dio().get(Url.dragons);
  }

  static Future<Response> getRockets() async {
    return Dio().get(Url.rockets);
  }

  static Future<Response> getShips() async {
    return Dio().get(Url.ships);
  }

  static Future<Response> getLandpad(String id) async {
    return Dio().get(Url.landpad + id);
  }

  static Future<Response> getLaunchpad(String id) async {
    return Dio().get(Url.launchpad + id);
  }
}
