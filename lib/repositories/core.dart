import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/details_core.dart';
import '../services/api_service.dart';
import '../util/photos.dart';
import 'index.dart';

/// Repository that holds information about a specific core.
class CoreRepository extends BaseRepository {
  /// Core serial: B0000
  final String id;

  CoreDetails core;
  List<String> photos;

  CoreRepository(this.id);

  @override
  Future<void> loadData([BuildContext context]) async {
    // Try to load the data using [ApiService]
    try {
      if (id != null) {
        // Receives the data and parse it
        final Response response = await ApiService.getCore(id);

        core = CoreDetails.fromJson(response.data);

        photos = List.from(SpaceXPhotos.cores);
        photos.shuffle();
      }

      finishLoading();
    } catch (_) {
      receivedError();
    }
  }
}
