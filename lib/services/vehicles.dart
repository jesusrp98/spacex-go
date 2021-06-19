import 'package:dio/dio.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';

import '../utils/index.dart';

/// Services that retrieves information about SpaceX's vehicles.
class VehiclesService extends BaseService<Dio> {
  const VehiclesService(Dio client) : super(client);

  Future<Response> getRoadster() async {
    return client.post(
      Url.roadster,
      data: ApiQuery.roadsterVehicle,
    );
  }

  Future<Response> getDragons() async {
    return client.post(
      Url.dragons,
      data: ApiQuery.dragonVehicle,
    );
  }

  Future<Response> getRockets() async {
    return client.post(
      Url.rockets,
      data: ApiQuery.rocketVehicle,
    );
  }

  Future<Response> getShips() async {
    return client.post(
      Url.ships,
      data: ApiQuery.shipVehicle,
    );
  }
}
