class Url {
  // Tesla Roadster page
  static const String roadsterPage =
      'https://api.spacexdata.com/v2/info/roadster';
  static const String roadsterWikipedia =
      'https://en.wikipedia.org/wiki/Elon_Musk%27s_Tesla_Roadster';

  static const List<String> detailsPage = [
    'https://api.spacexdata.com/v2/launchpads/',
    'https://api.spacexdata.com/v2/parts/cores/',
    'https://api.spacexdata.com/v2/parts/caps/',
  ];

  // Home page lists
  static const String rocketList = 'https://api.spacexdata.com/v2/rockets/';
  static const String capsuleList = 'https://api.spacexdata.com/v2/capsules';
  static const String upcomingList =
      'https://api.spacexdata.com/v2/launches/upcoming';
  static const String launchesList =
      'https://api.spacexdata.com/v2/launches?order=desc';

  // About page
  static const String authorReddit = 'https://www.reddit.com/user/jesusrp98';
  static const String storePage =
      'https://play.google.com/store/apps/details?id=com.chechu.hamilton';
  static const String paypalPage =
      'https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=LRH6Z3L44WXLY';
  static const String cherryGithub = 'https://github.com/jesusrp98/cherry';
  static const String spacexGithub = 'https://github.com/r-spacex/SpaceX-API';
  static const String internationalSystem =
      'https://en.wikipedia.org/wiki/International_System_of_Units';

  // Hero image
  static const String roadsterImage =
      'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/roadster.png?alt=media&token=ae9f1fa1-05c6-4faa-ab4d-74d0d562e0a5';
  static const String defaultImage =
      'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/rocket.png?alt=media&token=66f2dde6-e6ff-4f64-a4a4-9fab6dbe90c5';
  static const Map<String, String> vehicleImage = {
    'dragon1':
        'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/dragon1.png?alt=media&token=97e7674c-b5a9-49c5-a3db-b8b1507bd4c1',
    'dragon2':
        'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/dragon2.png?alt=media&token=6b67c56e-3895-4256-b0c2-eb9b1b8aef3f',
    'falcon1':
        'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/falcon1.jpg?alt=media&token=8015fe62-b2a5-418f-b37d-3641463f87c4',
    'falcon9':
        'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/falcon9.jpg?alt=media&token=96b5c764-a2ea-43f0-8766-1761db1749d4',
    'falconheavy':
        'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/falconheavy.jpg?alt=media&token=e9cdffae-fcdc-488c-9db5-587cc74e3255',
    'bfr':
        'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/bfr.jpg?alt=media&token=651d887f-7cf7-4991-9fa0-4617b4084a53',
  };
}
