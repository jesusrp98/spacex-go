import '../services/index.dart';
import 'index.dart';

class ChangelogRepository extends BaseRepository<ChangelogService, String> {
  const ChangelogRepository(ChangelogService service) : super(service);

  @override
  Future<String> fetchData() async {
    final response = await service.getChangelog();

    return response.data;
  }
}
