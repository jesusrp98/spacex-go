import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/launch.dart';
import '../services/api_service.dart';
import 'index.dart';

enum LaunchType { upcoming, latest }

class LaunchesRepository extends BaseRepository {
  final LaunchType type;

  List<Launch> launches;
  List<String> photos;

  LaunchesRepository(this.type);

  @override
  Future<void> loadData([BuildContext context]) async {
    try {
      final Response<List> response = await ApiService.getLaunches(type);
      launches = [for (final item in response.data) Launch.fromJson(item)];

      photos ??= launches.first.photos;
      photos.shuffle();

      finishLoading();
    } catch (e) {
      receivedError();
    }
  }
}
