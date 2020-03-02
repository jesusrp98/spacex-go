import 'package:dio/dio.dart';

import '../models/index.dart';
import '../models/launch.dart';
import '../services/api_service.dart';
import 'index.dart';

enum LaunchType { upcoming, latest }

/// Repository that holds a list of launches.
class LaunchesRepository extends BaseRepository {
  List<Launch> allLaunches;
  List<Launch> upcomingLaunches;
  List<Launch> latestLaunches;

  Stream<Launch> asd;

  @override
  Future<void> loadData() async {
    // Try to load the data using [ApiService]
    try {
      asd = Stream.empty();
      // Receives the data and parse it
      final Response<List> response = await ApiService.getLaunches();

      allLaunches = [for (final item in response.data) Launch.fromJson(item)];

      upcomingLaunches = allLaunches.where((launch) => launch.upcoming).toList()
        ..sort((a, b) => sortLaunches(LaunchType.upcoming, a, b));

      latestLaunches = allLaunches.where((launch) => !launch.upcoming).toList()
        ..sort((a, b) => sortLaunches(LaunchType.latest, a, b));

      // asd.pipe(streamConsumer);

      finishLoading();
    } on Exception catch (e) {
      print(e);
      receivedError();
    }
  }

  List<Launch> launches(LaunchType type) =>
      type == LaunchType.upcoming ? upcomingLaunches : latestLaunches;

  Launch getLaunch(int index) => allLaunches[index - 1];

  Launch get nextLaunch => upcomingLaunches?.first;
}

int sortLaunches(LaunchType type, Launch a, Launch b) =>
    type == LaunchType.upcoming
        ? a.number.compareTo(b.number)
        : b.number.compareTo(a.number);
