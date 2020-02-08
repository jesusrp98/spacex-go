import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/launch.dart';
import '../services/api_service.dart';
import 'index.dart';

enum LaunchType { upcoming, latest }

/// Repository that holds a list of launches.
class LaunchesRepository extends BaseRepository {
  final LaunchType type;

  List<Launch> launches;
  List<String> photos;

  LaunchesRepository(this.type);

  @override
  Future<void> loadData([BuildContext context]) async {
    // Try to load the data using [ApiService]
    try {
      // Receives the data and parse it
      final Response<List> response = await ApiService.getLaunches(type);

      launches = [for (final item in response.data) Launch.fromJson(item)];

      photos ??= launches.first.photos;
      photos.shuffle();

      finishLoading();
    } catch (_) {
      receivedError();
    }
  }
}
