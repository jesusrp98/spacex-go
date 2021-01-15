import '../services/index.dart';
import 'index.dart';

/// Repository that holds information about the changelog of this app.
class ChangelogRepository extends BaseRepository<ChangelogService> {
  String _changelog;

  ChangelogRepository(ChangelogService service) : super(service);

  @override
  Future<void> loadData() async {
    // Try to load the data using [ApiService]
    try {
      // Receives the data and parse it
      final response = await service.getChangelog();
      _changelog = response.data;

      finishLoading();
    } catch (e) {
      receivedError(e);
    }
  }

  String get changelog => _changelog;
}
