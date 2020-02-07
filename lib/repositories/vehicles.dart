import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/index.dart';
import '../models/info_roadster.dart';
import '../models/info_vehicle.dart';
import '../services/api_service.dart';
import 'index.dart';

class VehiclesRepository extends BaseRepository {
  List<VehicleInfo> vehicles;
  List<String> photos;

  VehiclesRepository();

  @override
  Future<void> loadData([BuildContext context]) async {
    try {
      final Response roadster = await ApiService.getRoadster();
      final Response<List> dragons = await ApiService.getDragons();
      final Response<List> rockets = await ApiService.getRockets();
      final Response<List> ships = await ApiService.getShips();

      vehicles = [
        RoadsterInfo.fromJson(roadster.data),
        for (final item in dragons.data) CapsuleInfo.fromJson(item),
        for (final item in rockets.data) RocketInfo.fromJson(item),
        for (final item in ships.data) ShipInfo.fromJson(item),
      ];

      if (photos.isEmpty) {
        final indices = List<int>.generate(7, (index) => index)
          ..shuffle()
          ..sublist(0, 5);

        photos = [for (final index in indices) vehicles[index].getRandomPhoto];
        photos.shuffle();
      }

      finishLoading();
    } catch (e) {
      receivedError();
    }
  }
}
