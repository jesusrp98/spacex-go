import '../models/index.dart';
import '../services/index.dart';
import 'base/index.dart';

class VehiclesCubit extends RequestCubit<VehiclesService, List<Vehicle>> {
  VehiclesCubit(VehiclesService service) : super(service);

  @override
  Future<void> fetchData() async {
    emit(RequestState.loading());

    try {
      final roadsterResponse = await service.getRoadster();
      final dragonResponse = await service.getDragons();
      final rocketResponse = await service.getRockets();
      final shipResponse = await service.getShips();

      final data = [
        RoadsterVehicle.fromJson(roadsterResponse.data),
        for (final item in dragonResponse.data['docs'])
          DragonVehicle.fromJson(item),
        for (final item in rocketResponse.data['docs'])
          RocketVehicle.fromJson(item),
        for (final item in shipResponse.data['docs'])
          ShipVehicle.fromJson(item),
      ];

      emit(RequestState.loaded(data));
    } catch (e) {
      emit(RequestState.error(e));
    }
  }
}
