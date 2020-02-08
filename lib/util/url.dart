/// Has all urls used in the app as static const strings.
class Url {
  //Base URLs
  static const String spacexBaseUrl = 'https://api.spacexdata.com/v3';

  // Vechiles URLs
  static const String rockets = '$spacexBaseUrl/rockets';
  static const String dragons = '$spacexBaseUrl/dragons';
  static const String roadster = '$spacexBaseUrl/roadster';
  static const String ships = '$spacexBaseUrl/ships?active=true';

  // Launches URLs
  static const String nextLaunch = '$spacexBaseUrl/launches/next';
  static const String upcomingLaunches = '$spacexBaseUrl/launches/upcoming';
  static const String latestLaunches =
      '$spacexBaseUrl/launches/past?order=desc';

  // Details URLs
  static const String core = '$spacexBaseUrl/cores/';
  static const String capsule = '$spacexBaseUrl/capsules/';
  static const String launchpad = '$spacexBaseUrl/launchpads/';
  static const String landpad = '$spacexBaseUrl/landpads/';

  // SpaceX info URLs
  static const String companyInformation = '$spacexBaseUrl/info';
  static const String companychievements = '$spacexBaseUrl/history';

  // Map URLs
  static const String lightMap =
      'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png';
  static const String darkMap =
      'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png';

  // Share details message
  static const String shareDetails = '#spacexGO';

  // About page
  static const String authorProfile = 'https://twitter.com/jesusrp98';
  static const String authorPatreon = 'https://www.patreon.com/jesusrp98';
  static const String authorEmail =
      'mailto:spacex.go.app@gmail.com?subject=About%20SpaceX GO!';

  static const String changelog =
      'https://raw.githubusercontent.com/jesusrp98/spacex-go/master/CHANGELOG.md';
  static const String appSource = 'https://github.com/jesusrp98/spacex-go';
  static const String apiSource = 'https://github.com/r-spacex/SpaceX-API';
  static const String flutterPage = 'https://flutter.dev/';
}
