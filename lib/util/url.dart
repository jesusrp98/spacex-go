/// Has all urls used in the app as static const strings.
class Url {
  //Base URLs
  static const String spacexBaseUrl = 'https://api.spacexdata.com/v3';

  // Home page lists
  static const String rocketList = '$spacexBaseUrl/rockets';
  static const String capsuleList = '$spacexBaseUrl/dragons';
  static const String roadsterPage = '$spacexBaseUrl/roadster';
  static const String upcomingList = '$spacexBaseUrl/launches/upcoming';
  static const String launchesList = '$spacexBaseUrl/launches/past?order=desc';
  static const String shipsList = '$spacexBaseUrl/ships?active=true';

  // Upcoming launch for Home screen
  static const String nextLaunch = '$spacexBaseUrl/launches/next';

  // FH maiden launch
  static const String roadsterVideo = 'https://youtu.be/wbSwFU6tY1c';

  // Details dialogs
  static const String coreDialog = '$spacexBaseUrl/cores/';
  static const String capsuleDialog = '$spacexBaseUrl/capsules/';
  static const String launchpadDialog = '$spacexBaseUrl/launchpads/';
  static const String landingpadDialog = '$spacexBaseUrl/landpads/';

  // SpaceX related info
  static const String spacexCompany = '$spacexBaseUrl/info';
  static const String spacexAchievements = '$spacexBaseUrl/history';

  // Map URL
  static const String lightMap =
      'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png';
  static const String darkMap =
      'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png';

  // Share details message
  static const String shareDetails = '#spacexGO';

  // About page
  static const String authorProfile = 'https://twitter.com/jesusrp98';
  static const String authorPatreon = 'https://www.patreon.com/jesusrp98';
  static const Map<String, String> authorEmail = {
    'subject': 'About SpaceX GO!',
    'address': 'spacex.go.app@gmail.com',
  };
  static const String changelog =
      'https://raw.githubusercontent.com/jesusrp98/spacex-go/dev/CHANGELOG.md';
  static const String appSource = 'https://github.com/jesusrp98/spacex-go';
  static const String apiSource = 'https://github.com/r-spacex/SpaceX-API';
  static const String flutterPage = 'https://flutter.dev/';
}
