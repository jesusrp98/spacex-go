import 'package:cherry/models/index.dart';
import 'package:cherry/services/index.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';

/// Handles retrieve and transformation of [Vehicles] from the API.
/// This includes:
/// - Elon's Tesla Roadster car.
/// - Dragon capsules information.
/// - Rocket vehicles information.
/// - Various active ships information.
class VehiclesRepository
    extends RequestRepository<VehiclesService, List<Vehicle>> {
  VehiclesRepository(super.service);

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

  Vehicle? getVehicle(String id) {
    if (state.status == RequestStatus.loaded) {
      return state.value!.where((l) => l.id == id).single;
    } else {
      return null;
    }
  }
}
