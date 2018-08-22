/// URL CLASS
/// It has all urls used in the app as static const strings
class Url {
  /// Home page lists
  static const String rocketList = 'https://api.spacexdata.com/v2/rockets/';
  static const String capsuleList = 'https://api.spacexdata.com/v2/capsules';
  static const String roadsterPage =
      'https://api.spacexdata.com/v2/info/roadster';
  static const String upcomingList =
      'https://api.spacexdata.com/v2/launches/upcoming';
  static const String launchesList =
      'https://api.spacexdata.com/v2/launches?order=desc';

  /// Details dialogs
  static const List<String> detailsPage = [
    'https://api.spacexdata.com/v2/launchpads/',
    'https://api.spacexdata.com/v2/parts/cores/',
    'https://api.spacexdata.com/v2/parts/caps/',
  ];

  /// Hero image
  static const String defaultImage =
      'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/rocket.png?alt=media&token=66f2dde6-e6ff-4f64-a4a4-9fab6dbe90c5';
  static const Map<String, String> vehicleImage = {
    'roadster':
        'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/roadster.jpg?alt=media&token=8f1c0013-727b-4ce7-bcee-3cd1999bdb45',
    'dragon1':
        'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/dragon1.jpg?alt=media&token=1e6b7802-1013-4e1c-9c14-7456b0f0bdb9',
    'dragon2':
        'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/dragon2.jpg?alt=media&token=f240d81d-e56e-4626-be3a-2169bdbaa10b',
    'falcon1':
        'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/falcon1.jpg?alt=media&token=8015fe62-b2a5-418f-b37d-3641463f87c4',
    'falcon9':
        'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/falcon9.jpg?alt=media&token=96b5c764-a2ea-43f0-8766-1761db1749d4',
    'falconheavy':
        'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/falconheavy.jpg?alt=media&token=e9cdffae-fcdc-488c-9db5-587cc74e3255',
    'bfr':
        'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/bfr.jpg?alt=media&token=651d887f-7cf7-4991-9fa0-4617b4084a53',
  };

  /// About page
  static const String authorReddit = 'https://www.reddit.com/user/jesusrp98';
  static const String storePage =
      'https://play.google.com/store/apps/details?id=com.chechu.cherry';
  static const String paypalPage =
      'https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=LRH6Z3L44WXLY';
  static const String cherryGithub = 'https://github.com/jesusrp98/cherry';
  static const String spacexGithub = 'https://github.com/r-spacex/SpaceX-API';
  static const String internationalSystem =
      'https://en.wikipedia.org/wiki/International_System_of_Units';
}
