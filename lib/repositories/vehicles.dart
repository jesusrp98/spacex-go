import 'package:flutter_request_bloc/flutter_request_bloc.dart';

import '../models/index.dart';
import '../services/index.dart';

/// Handles retrieve and transformation of [Vehicles] from the API.
/// This includes:
/// - Elon's Tesla Roadster car.
/// - Dragon capsules information.
/// - Rocket vehicles information.
/// - Various active ships information.
class VehiclesRepository
    extends BaseRepository<VehiclesService, List<Vehicle>> {
  VehiclesRepository(VehiclesService service) : super(service);

  @override
  Future<List<Vehicle>> fetchData() async {
    final roadsterResponse = await service.getRoadster();
    final dragonResponse = await service.getDragons();
    final rocketResponse = await service.getRockets();
    final shipResponse = await service.getShips();

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
