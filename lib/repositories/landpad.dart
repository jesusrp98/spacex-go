import 'package:dio/dio.dart';

import '../models/index.dart';
import '../services/api_service.dart';
import 'index.dart';

/// Repository that holds information about a specific landpad.
class LandpadRepository extends BaseRepository {
  /// Core serial: B0000
  final String id;

  Landpad landpad;

  LandpadRepository(this.id);

  @override
  Future<void> loadData() async {
    // Try to load the data using [ApiService]
    try {
      // Receives the data and parse it
      if (id != null) {
        final Response response = await ApiService.getLandpad(id);

        landpad = Landpad.fromJson(response.data);
      }

      finishLoading();
    } catch (_) {
      receivedError();
    }
  }
}
