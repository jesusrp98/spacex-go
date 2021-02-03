import '../models/index.dart';

/// Useful methods used for perform various tasks inside a list of `Launch` objects.
class LaunchUtils {
  /// Returs the most upcoming launch inside a list, if the list
  /// is sorted by date.
  static Launch getUpcomingLaunch(List<List<Launch>> launches) {
    if (launches != null) {
      return launches[0].first;
    } else {
      return null;
    }
  }

  /// Returs the most latest launch inside a list, if the list
  /// is sorted by date.
  static Launch getLatestLaunch(List<List<Launch>> launches) {
    if (launches != null) {
      return launches[1].first;
    } else {
      return null;
    }
  }

  /// Returns all launches combined into one single list.
  static List<Launch> getAllLaunches(List<List<Launch>> launches) {
    if (launches != null) {
      return List.from([...launches[0], ...launches[1]]);
    } else {
      return null;
    }
  }
}
