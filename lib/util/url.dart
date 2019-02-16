/// URL FILE
/// It has all urls used in the app as static const strings.
class Url {
  //Base urls
  static const String spacexBaseUrl = 'https://api.spacexdata.com/v3';
  static const String firebaseBaseUrl = 'gs://cherry-3ca39.appspot.com';

  // Home page lists
  static const String rocketList = '$spacexBaseUrl/rockets';
  static const String capsuleList = '$spacexBaseUrl/dragons';
  static const String roadsterPage = '$spacexBaseUrl/roadster';
  static const String upcomingList = '$spacexBaseUrl/launches/upcoming';
  static const String launchesList = '$spacexBaseUrl/launches/past?order=desc';
  static const String shipsList = '$spacexBaseUrl/ships?active=true';

  // Upcoming launch for Home screen
  static const String nextLaunch = '$spacexBaseUrl/launches/next';

  // FH maiden launch for Tesla Roadster's page
  static const String roadsterVideo = 'https://youtu.be/wbSwFU6tY1c';

  // Details dialogs
  static const List<String> detailsPage = [
    '$spacexBaseUrl/launchpads/',
    '$spacexBaseUrl/cores/',
    '$spacexBaseUrl/capsules/',
  ];
  static const String coreDialog = '$spacexBaseUrl/cores/';
  static const String capsuleDialog = '$spacexBaseUrl/capsules/';
  static const String launchpadDialog = '$spacexBaseUrl/launchpads/';
  static const String landingpadDialog = '$spacexBaseUrl/landpads/';

  // SpaceX related info
  static const String spacexCompany = '$spacexBaseUrl/info';
  static const String spacexAchievements = '$spacexBaseUrl/history';

  // static const List<String> spacexCompanyScreen = [
  //   'https://www.spacex.com/sites/spacex/files/styles/media_gallery_large/public/2014_-_11orbcomm_f9_in_hanger.jpg?itok=gqP7Qmrg',
  //   'https://farm1.staticflickr.com/342/18039170043_e2ca8b540a_c.jpg',
  //   'https://farm9.staticflickr.com/8571/16491695667_c2754ff48e_c.jpg',
  //   'https://farm9.staticflickr.com/8688/17024507155_2168c8d032_c.jpg',
  //   'https://www.spacex.com/sites/spacex/files/styles/media_gallery_large/public/first_reflight_-_05_crs8_recovered_first_stage_3.jpg?itok=nHqaeNdH',
  // ];

  // static const List<String> spacexUpcomingScreen = [
  //   'https://farm5.staticflickr.com/4183/34296430820_c48e601ca1_c.jpg',
  //   'https://farm1.staticflickr.com/293/32312415025_6841e30bf1_c.jpg',
  //   'https://farm5.staticflickr.com/4483/37610547226_c8002032bc_c.jpg',
  //   'https://farm5.staticflickr.com/4235/35359372730_99255c4a20_c.jpg',
  //   'https://farm9.staticflickr.com/8601/16512864369_27bb414c91_c.jpg',
  // ];

  // static const List<String> spacexHomeScreen = [
  //   'https://www.spacex.com/sites/spacex/files/styles/media_gallery_large/public/2014_-_11orbcomm_f9_in_hanger.jpg?itok=gqP7Qmrg',
  //   'https://farm2.staticflickr.com/1854/30934146778_765ea9f486_c.jpg',
  //   'https://farm5.staticflickr.com/4615/40143096241_11128929df_c.jpg',
  //   'https://farm5.staticflickr.com/4227/34223076793_569a584d33_c.jpg',
  //   'https://www.spacex.com/sites/spacex/files/styles/media_gallery_large/public/2015_-_04_crs5_dragon_orbit13.jpg?itok=9p8_l7UP',
  //   'https://www.spacex.com/sites/spacex/files/styles/media_gallery_large/public/2015_-_12_default_crew_dragon_interior_wide.jpg?itok=MXp4IjW4',
  // ];

  // static const List<String> spacexCoreDialog = [
  //   'https://farm2.staticflickr.com/1670/26239020092_e1f620900e_c.jpg',
  //   'https://farm8.staticflickr.com/7135/27042449393_5782749d32_c.jpg',
  //   'https://farm5.staticflickr.com/4654/25254688767_83c0563d06_c.jpg',
  //   'https://farm8.staticflickr.com/7070/26428479314_75e78939f9_c.jpg',
  //   'https://farm5.staticflickr.com/4352/36438808381_1da8beb65c_c.jpg',
  // ];

  // static const List<String> spacexCapsuleDialog = [
  //   'https://www.spacex.com/sites/spacex/files/styles/media_gallery_large/public/2013_-_5_731710main_iss034e060657_full.jpg?itok=JyR6tNGL',
  //   'https://www.spacex.com/sites/spacex/files/styles/media_gallery_large/public/2015_-_04_crs5_dragon_orbit13.jpg?itok=9p8_l7UP',
  //   'https://farm3.staticflickr.com/2815/32761844973_4b55b27d3c_c.jpg',
  //   'https://farm9.staticflickr.com/8664/16669501448_78441c1024_c.jpg',
  //   'https://farm8.staticflickr.com/7591/16787988882_0b9896dc9f_c.jpg',
  // ];

  // static const String defaultImage =
  //     'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/rocket.png?alt=media&token=66f2dde6-e6ff-4f64-a4a4-9fab6dbe90c5';

  // static const String defaultImage = '$firebaseBaseUrl/rocket.png';

  // Map URL
  static const String mapView =
      'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png';

  // Share details message
  static const String shareDetails = '#spacexGO $cherryStore';

  // About page
  static const String authorReddit = 'https://www.reddit.com/user/jesusrp98';
  static const String authorStore =
      'https://play.google.com/store/apps/developer?id=Jes%C3%BAs+Rodr%C3%ADguez+P%C3%A9rez';
  static const String cherryStore =
      'https://play.google.com/store/apps/details?id=com.chechu.cherry';
  static const String cherryGithub = 'https://github.com/jesusrp98/spacex-go';
  static const String authorEmail =
      'mailto:spacex.go.app@gmail.com?subject=About%20SpaceX%20GO!';
  static const String apiGithub = 'https://github.com/r-spacex/SpaceX-API';
  static const String internationalSystem =
      'https://en.wikipedia.org/wiki/International_System_of_Units';
  static const String spacexPage = 'https://www.spacex.com/';
  static const String flutterPage = 'https://flutter.io/';
}
