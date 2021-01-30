import '../models/index.dart';

class LaunchUtils {
  ///
  static Launch getUpcomingLaunch(List<Launch> launches) {
    return launches.where((l) => l.upcoming).first;
  }

  ///
  static Launch getLatestLaunch(List<Launch> launches) {
    return launches.where((l) => !l.upcoming).first;
  }
}
