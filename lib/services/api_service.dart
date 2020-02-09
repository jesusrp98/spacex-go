import 'package:dio/dio.dart';

import '../util/url.dart';

/// Serves data to several data repositories.
///
/// Makes http calls to several services, including
/// the open source r/SpaceX REST API.
class ApiService {
  /// Retrieves cherry's changelog file from GitHub.
  static Future<Response> getChangelog() async {
    return Dio().get(Url.changelog);
  }

  /// Retrieves a list featuring the latest SpaceX acomplishments.
  static Future<Response<List>> getAchievements() async {
    return Dio().get(Url.companychievements);
  }

  /// Retrieves general information about SpaceX.
  static Future<Response> getCompanyInformation() async {
    return Dio().get(Url.companyInformation);
  }

  /// Retrieves information about a specific capsule.
  static Future<Response> getCapsule(String id) async {
    return Dio().get(Url.capsule + id);
  }

  /// Retrieves information about a specific core.
  static Future<Response> getCore(String id) async {
    return Dio().get(Url.core + id);
  }

  /// Retrieves a list of featuring information about upcoming and latest launches.
  static Future<Response<List>> getLaunches() async {
    return Dio().get(Url.launches);
  }

  /// Retrieves information about the latest SpaceX mission.
  static Future<Response> getNextLaunch() async {
    return Dio().get(Url.nextLaunch);
  }

  /// Retireves information about the Tesla Roadster launched on February 2018.
  static Future<Response> getRoadster() async {
    return Dio().get(Url.roadster);
  }

  /// Retrieves a list featuring all Dragon capsules.
  static Future<Response<List>> getDragons() async {
    return Dio().get(Url.dragons);
  }

  /// Retrieves a list featuring all rocket developed by SpaceX.
  static Future<Response<List>> getRockets() async {
    return Dio().get(Url.rockets);
  }

  /// Retrieves a list featuring all ships used by SpaceX.
  static Future<Response<List>> getShips() async {
    return Dio().get(Url.ships);
  }

  /// Retrieves information about a specific landpad.
  static Future<Response> getLandpad(String id) async {
    return Dio().get(Url.landpad + id);
  }

  /// Retrieves information about a specific launchpad.
  static Future<Response> getLaunchpad(String id) async {
    return Dio().get(Url.launchpad + id);
  }
}
