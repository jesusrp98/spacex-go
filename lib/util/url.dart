/// Has all urls used in the app as static const strings.
class Url {
  // API keys
  static const stadiaKey = '0a781f97-5aed-4ac9-bcb9-e15c13d65806';

  //Base URLs
  static const spacexBaseUrl = 'https://api.spacexdata.com/v4';

  // Vechiles URLs
  static const rockets = '$spacexBaseUrl/rockets/query';
  static const dragons = '$spacexBaseUrl/dragons/query';
  static const roadster = '$spacexBaseUrl/roadster/query';
  static const ships = '$spacexBaseUrl/ships/query';

  // Launch URL
  static const launches = '$spacexBaseUrl/launches/query';

  // SpaceX info URLs
  static const companyInformation = '$spacexBaseUrl/company';
  static const companyAchievements = '$spacexBaseUrl/history';

  // Map URLs
  static const lightMap =
      'https://tiles.stadiamaps.com/tiles/alidade_smooth/{z}/{x}/{y}@2x.png?api_key=$stadiaKey';
  static const darkMap =
      'https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}@2x.png?api_key=$stadiaKey';

  // Share details message
  static const shareDetails = '#spacexGO';

  // About page
  static const authorProfile = 'https://twitter.com/jesusrp98';
  static const authorPatreon = 'https://www.patreon.com/jesusrp98';
  static const emailUrl = 'mailto:spacex.go.app@gmail.com?subject=About SpaceX GO!';

  static const changelog =
      'https://raw.githubusercontent.com/jesusrp98/spacex-go/master/CHANGELOG.md';
  static const appSource = 'https://github.com/jesusrp98/spacex-go';
  static const apiSource = 'https://github.com/r-spacex/SpaceX-API';
  static const flutterPage = 'https://flutter.dev';
}
