import '../models/index.dart';
import '../services/index.dart';
import 'index.dart';

/// Handles retrieve and transformation of [Launch] from the API, both past & future ones.
class LaunchesRepository extends BaseRepository<LaunchesService, List<Launch>> {
  LaunchesRepository(LaunchesService service) : super(service);

  @override
  Future<List<Launch>> fetchData() async {
    final response = await service.getLaunches();

    return [for (final item in response.data['docs']) Launch.fromJson(item)]
      ..sort((b, a) => a.compareTo(b));
  }
}
