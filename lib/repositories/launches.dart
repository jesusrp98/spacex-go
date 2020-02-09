import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/launch.dart';
import '../services/api_service.dart';
import 'index.dart';

enum LaunchType { upcoming, latest }

/// Repository that holds a list of launches.
class LaunchesRepository extends BaseRepository {
  List<Launch> upcomingLaunches;
  List<Launch> latestLaunches;

  List<String> upcomingPhotos;
  List<String> latestPhotos;

  LaunchesRepository();

  @override
  Future<void> loadData([BuildContext context]) async {
    // Try to load the data using [ApiService]
    try {
      // Receives the data and parse it
      final Response<List> response = await ApiService.getLaunches();

      final aux = [for (final item in response.data) Launch.fromJson(item)];

      upcomingLaunches = aux.where((launch) => launch.upcoming).toList()
        ..sort((a, b) => sortLaunches(LaunchType.upcoming, a, b));

      latestLaunches = aux.where((launch) => !launch.upcoming).toList()
        ..sort((a, b) => sortLaunches(LaunchType.latest, a, b));

      upcomingPhotos ??= upcomingLaunches.first.photos;
      upcomingPhotos.shuffle();

      latestPhotos ??= latestLaunches.first.photos;
      latestPhotos.shuffle();

      finishLoading();
    } catch (_) {
      receivedError();
    }
  }

  List<String> photos(LaunchType type) =>
      type == LaunchType.upcoming ? upcomingPhotos : latestPhotos;

  List<Launch> launches(LaunchType type) =>
      type == LaunchType.upcoming ? upcomingLaunches : latestLaunches;
}

int sortLaunches(LaunchType type, Launch a, Launch b) =>
    type == LaunchType.upcoming
        ? a.number.compareTo(b.number)
        : b.number.compareTo(a.number);
