import 'package:dio/dio.dart';

import '../models/index.dart';
import '../util/index.dart';
import 'base/index.dart';

class VehiclesRepository extends RequestRepository<List<Vehicle>> {
  VehiclesRepository(Dio client) : super(client);

  @override
  Future<List<Vehicle>> fetchData() async {
    final roadsterResponse = await client.post(
      Url.roadster,
      data: ApiQuery.roadsterVehicle,
    );

    final dragonResponse = await client.post(
      Url.dragons,
      data: ApiQuery.dragonVehicle,
    );

    final rocketResponse = await client.post(
      Url.rockets,
      data: ApiQuery.rocketVehicle,
    );

    final shipResponse = await client.post(
      Url.ships,
      data: ApiQuery.shipVehicle,
    );

    return [
      RoadsterVehicle.fromJson(roadsterResponse.data),
      for (final item in dragonResponse.data['docs'])
        DragonVehicle.fromJson(item),
      for (final item in rocketResponse.data['docs'])
        RocketVehicle.fromJson(item),
      for (final item in shipResponse.data['docs']) ShipVehicle.fromJson(item),
    ];
  }
}
