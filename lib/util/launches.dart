import '../models/index.dart';

class LaunchUtil {
  /// TODO
  static Launch getUpcomingLaunch(List<Launch> launches) {
    return launches.where((l) => l.upcoming).first;
  }

  /// TODO
  static Launch getLatestLaunch(List<Launch> launches) {
    return launches.where((l) => !l.upcoming).first;
  }
}
