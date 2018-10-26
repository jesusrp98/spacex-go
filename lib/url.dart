/// URL CLASS
/// It has all urls used in the app as static const strings
class Url {
  /// Home page lists
  static const String rocketList = 'https://api.spacexdata.com/v3/rockets';
  static const String capsuleList = 'https://api.spacexdata.com/v3/dragons';
  static const String roadsterPage = 'https://api.spacexdata.com/v3/roadster';
  static const String upcomingList =
      'https://api.spacexdata.com/v3/launches/upcoming';
  static const String launchesList =
      'https://api.spacexdata.com/v3/launches/past?order=desc';
  static const String shipsList =
      'https://api.spacexdata.com/v3/ships?active=true';

  /// Details dialogs
  static const List<String> detailsPage = [
    'https://api.spacexdata.com/v3/launchpads/',
    'https://api.spacexdata.com/v3/cores/',
    'https://api.spacexdata.com/v3/capsules/',
  ];

  /// Hero images
  static const String defaultImage =
      'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/rocket.png?alt=media&token=66f2dde6-e6ff-4f64-a4a4-9fab6dbe90c5';

  /// About page
  static const String authorReddit = 'https://www.reddit.com/user/jesusrp98';
  static const String authorStore =
      'https://play.google.com/store/apps/developer?id=Chechu';
  static const String storePage =
      'https://play.google.com/store/apps/details?id=com.chechu.cherry';
  static const String cherryGithub = 'https://github.com/jesusrp98/spacex-go';
  static const String email =
      'mailto:jesusillorp98@gmail.com?subject=Email%20about%20SpaceX%20GO!';
  static const String spacexGithub = 'https://github.com/r-spacex/SpaceX-API';
  static const String internationalSystem =
      'https://en.wikipedia.org/wiki/International_System_of_Units';
}
