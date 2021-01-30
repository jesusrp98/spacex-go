import '../models/index.dart';

/// Useful methods used for perform various tasks inside a list of `Launch` objects.
class LaunchUtils {
  /// Returs the most upcoming launch inside a list, if the list
  /// is sorted by date.
  static Launch getUpcomingLaunch(List<Launch> launches) {
    if (launches != null) {
      return launches.reversed.where((l) => l.upcoming).first;
    } else {
      return null;
    }
  }

  /// Returs the most latest launch inside a list, if the list
  /// is sorted by date.
  static Launch getLatestLaunch(List<Launch> launches) {
    if (launches != null) {
      return launches.where((l) => !l.upcoming).first;
    } else {
      return null;
    }
  }
}
