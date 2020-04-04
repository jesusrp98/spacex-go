import 'package:dio/dio.dart';

import '../models/index.dart';
import '../services/api_service.dart';
import 'index.dart';

/// Repository that holds information about a specific launchpad.
class LaunchpadRepository extends BaseRepository {
  /// Core serial: B0000
  final String id, name;

  Launchpad launchpad;

  LaunchpadRepository(this.id, this.name);

  @override
  Future<void> loadData() async {
    // Try to load the data using [ApiService]
    try {
      if (id != null) {
        // Receives the data and parse it
        final Response response = await ApiService.getLaunchpad(id);
        launchpad = Launchpad.fromJson(response.data);
      }

      finishLoading();
    } catch (_) {
      receivedError();
    }
  }
}
