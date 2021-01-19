import '../models/index.dart';
import '../services/index.dart';
import 'index.dart';

class LaunchesRepository extends BaseRepository<LaunchesService, List<Launch>> {
  LaunchesRepository(LaunchesService service) : super(service);

  @override
  Future<List<Launch>> fetchData() async {
    final response = await service.getLaunches();

    return [for (final item in response.data['docs']) Launch.fromJson(item)];
  }
}
