import 'package:dio/dio.dart';

import '../models/index.dart';
import '../models/info_roadster.dart';
import '../models/info_vehicle.dart';
import '../services/api_service.dart';
import 'index.dart';

/// Repository that holds a list of SpaceX vehicles.
class VehiclesRepository extends BaseRepository {
  List<VehicleInfo> vehicles;
  List<String> photos;

  VehiclesRepository();

  @override
  Future<void> loadData() async {
    // Try to load the data using [ApiService]
    try {
      // Receives the data and parse it
      final Response roadster = await ApiService.getRoadster();
      final Response<List> dragons = await ApiService.getDragons();
      final Response<List> rockets = await ApiService.getRockets();
      final Response<List> ships = await ApiService.getShips();

      vehicles = [
        RoadsterInfo.fromJson(roadster.data),
        for (final item in dragons.data) DragonInfo.fromJson(item),
        for (final item in rockets.data) RocketInfo.fromJson(item),
        for (final item in ships.data) ShipInfo.fromJson(item),
      ];

      if (photos == null) {
        final indices = List<int>.generate(7, (index) => index)
          ..shuffle()
          ..sublist(0, 5);

        photos = [for (final index in indices) vehicles[index].getRandomPhoto];
        photos.shuffle();
      }
      finishLoading();
    } catch (_) {
      receivedError();
    }
  }

  RoadsterInfo get roadster =>
      vehicles.where((vehicle) => vehicle.id == 'roadster').first;

  VehicleInfo getVehicle(String id) =>
      vehicles.where((vehicle) => vehicle.id == id).first;
}
