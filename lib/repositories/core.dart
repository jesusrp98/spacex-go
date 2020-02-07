import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/details_core.dart';
import '../services/api_service.dart';
import '../util/photos.dart';
import 'index.dart';

class CoreRepository extends BaseRepository {
  /// Core serial: B0000
  final String id;

  CoreDetails core;
  List<String> photos;

  CoreRepository(this.id);

  @override
  Future<void> loadData([BuildContext context]) async {
    try {
      if (id != null) {
        final Response response = await ApiService.getCore(id);
        core = CoreDetails.fromJson(response.data);

        photos = SpaceXPhotos.capsules;
        photos.shuffle();
      }

      finishLoading();
    } catch (e) {
      receivedError();
    }
  }
}
