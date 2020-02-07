import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../services/api_service.dart';
import 'index.dart';

class ChangelogRepository extends BaseRepository {
  String changelog;

  @override
  Future<void> loadData([BuildContext context]) async {
    try {
      final Response response = await ApiService.getChangelog();
      changelog = response.data;

      finishLoading();
    } catch (e) {
      receivedError();
    }
  }
}
