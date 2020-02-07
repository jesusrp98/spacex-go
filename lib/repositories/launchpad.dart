import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/index.dart';
import '../services/api_service.dart';
import 'index.dart';

class LaunchpadRepository extends BaseRepository {
  /// Core serial: B0000
  final String id, name;

  Launchpad launchpad;

  LaunchpadRepository(this.id, this.name);

  @override
  Future<void> loadData([BuildContext context]) async {
    try {
      if (id != null) {
        final Response response = await ApiService.getLandpad(id);
        launchpad = Launchpad.fromJson(response.data);
      }

      finishLoading();
    } catch (e) {
      receivedError();
    }
  }
}
