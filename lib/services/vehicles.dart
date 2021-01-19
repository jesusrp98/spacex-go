import 'package:dio/dio.dart';

import '../util/index.dart';
import 'index.dart';

/// Services that retrieves information about SpaceX's vehicles.
class VehiclesService extends BaseService<Dio> {
  const VehiclesService(Dio client) : super(client);

  /// Retireves information about the Tesla Roadster launched on February 2018.
  Future<Response> getRoadster() async {
    return client.post(
      Url.roadster,
      data: ApiQuery.roadsterVehicle,
    );
  }

  /// Retrieves a list featuring all Dragon capsules.
  Future<Response> getDragons() async {
    return client.post(
      Url.dragons,
      data: ApiQuery.dragonVehicle,
    );
  }

  /// Retrieves a list featuring all rocket developed by SpaceX.
  Future<Response> getRockets() async {
    return client.post(
      Url.rockets,
      data: ApiQuery.rocketVehicle,
    );
  }

  /// Retrieves a list featuring all ships used by SpaceX.
  Future<Response> getShips() async {
    return client.post(
      Url.ships,
      data: ApiQuery.shipVehicle,
    );
  }
}
