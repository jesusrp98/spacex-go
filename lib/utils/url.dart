/// Has all urls used in the app as static const strings.
class Url {
  //Base URLs
  static const spacexBaseUrl = 'https://api.spacexdata.com';

  // Vechiles URLs
  static const rockets = '$spacexBaseUrl/v4/rockets/query';
  static const dragons = '$spacexBaseUrl/v4/dragons/query';
  static const roadster = '$spacexBaseUrl/v4/roadster/query';
  static const ships = '$spacexBaseUrl/v4/ships/query';

  // Launch URL
  static const launches = '$spacexBaseUrl/v5/launches/query';

  // SpaceX info URLs
  static const companyInformation = '$spacexBaseUrl/v4/company';
  static const companyAchievements = '$spacexBaseUrl/v4/history';

  // Share details message
  static const shareDetails = '#spacexGO';

  // About page
  static const authorProfile = 'https://twitter.com/jesusrp98';
  static const authorPatreon = 'https://www.patreon.com/jesusrp98';
  static const emailUrl =
      'mailto:spacex.go.app@gmail.com?subject=About SpaceX GO!';

  static const changelog =
      'https://raw.githubusercontent.com/jesusrp98/spacex-go/master/CHANGELOG.md';
  static const appSource = 'https://github.com/jesusrp98/spacex-go';
  static const apiSource = 'https://github.com/r-spacex/SpaceX-API';
  static const flutterPage = 'https://flutter.dev';
}
