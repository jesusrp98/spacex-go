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
    'GONAVIGATOR':
        'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/gonavigator.jpg?alt=media&token=1192551d-6b0b-40e5-b556-cf1f2f149053',
    'GOQUEST':
        'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/goquest.jpg?alt=media&token=af1504ef-a2c9-4ffe-bb85-c63dc75acefe',
    'GOSEARCHER':
        'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/gosearcher.jpg?alt=media&token=ced7bd1a-1e79-41f1-ad89-7fb231a68db0',
    'HAWK':
        'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/hawn.jpg?alt=media&token=65e1d71e-c068-425b-b72b-17c635451868',
    'JRTI-2':
        'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/JRTI-2.jpg?alt=media&token=12eae5a3-8bff-43da-912f-31c544def7c3',
    'MRSTEVEN':
        'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/MRSTEVEN.jpg?alt=media&token=351c5d89-41df-42a4-a738-99f2a34c9ef2',
    'NRCQUEST':
        'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/nrcquest.jpg?alt=media&token=43c92d49-67eb-4b1d-a669-e26c9284b457',
    'OCISLY':
        'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/OCISLY.jpg?alt=media&token=657af104-1f43-4e7d-830d-d99f8f2a8a1f',
    'PACIFICFREEDOM':
        'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/pacificfreedom.jpg?alt=media&token=3333e26e-b3da-41ed-b0f3-a29479243911',
  };

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
