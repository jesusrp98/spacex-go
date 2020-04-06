import 'package:dio/dio.dart';

import '../services/api_service.dart';
import 'index.dart';

/// Repository that holds information about the changelog of this app.
class ChangelogRepository extends BaseRepository {
  String changelog;

  @override
  Future<void> loadData() async {
    // Try to load the data using [ApiService]
    try {
      // Receives the data and parse it
      final Response response = await ApiService.getChangelog();
      changelog = response.data;

      finishLoading();
    } catch (_) {
      receivedError();
    }
  }
}
