import '../models/index.dart';
import '../services/index.dart';
import '../util/index.dart';
import 'index.dart';

enum LaunchType { upcoming, past }

/// Repository that holds a list of launches.
class LaunchesRepository extends BaseRepository<LaunchesService> {
  List<Launch> _launches;

  LaunchesRepository(LaunchesService service) : super(service);

  @override
  Future<void> loadData() async {
    // Try to load the data using [ApiService]
    try {
      // Receives the data and parse it
      final response = await service.getLaunches();

      _launches = [
        for (final item in response.data['docs']) Launch.fromJson(item)
      ];

      _launches.sort((a, b) => a.compareTo(b));

      finishLoading();
    } catch (_) {
      receivedError();
    }
  }

  List<Launch> getLaunches(LaunchType type) =>
      (type == LaunchType.upcoming ? _launches : _launches?.reversed)
          ?.where((launch) => launch?.upcoming == (type == LaunchType.upcoming))
          ?.toList();

  Launch getLaunch(String id) =>
      _launches?.where((launch) => launch.id == id)?.first;

  Launch get upcomingLaunch => getLaunches(LaunchType.upcoming)?.first;

  int getLaunchesCount(LaunchType type) => getLaunches(type)?.length;

  List<String> getPhotos(LaunchType type) {
    final auxLaunch = getLaunches(type).first;

    return auxLaunch.hasPhotos ? auxLaunch.photos : SpaceXPhotos.upcoming;
  }
}
