import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/details_capsule.dart';
import '../services/api_service.dart';
import '../util/photos.dart';
import 'index.dart';

class CapsuleRepository extends BaseRepository {
  /// Capsule serial: C0000
  final String id;

  CapsuleDetails capsule;
  List<String> photos;

  CapsuleRepository(this.id);

  @override
  Future<void> loadData([BuildContext context]) async {
    try {
      if (id != null) {
        final Response response = await ApiService.getCapsule(id);
        capsule = CapsuleDetails.fromJson(response.data);

        photos = List.from(SpaceXPhotos.capsules);
        photos.shuffle();
      }

      finishLoading();
    } catch (e) {
      receivedError();
    }
  }
}
