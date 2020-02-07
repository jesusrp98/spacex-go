import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/index.dart';
import '../services/api_service.dart';
import 'index.dart';

class LandpadRepository extends BaseRepository {
  /// Core serial: B0000
  final String id;

  Landpad landpad;

  LandpadRepository(this.id);

  @override
  Future<void> loadData([BuildContext context]) async {
    try {
      if (id != null) {
        final Response response = await ApiService.getLandpad(id);
        landpad = Landpad.fromJson(response.data);
      }

      finishLoading();
    } catch (e) {
      receivedError();
    }
  }
}
