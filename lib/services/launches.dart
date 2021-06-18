import 'package:dio/dio.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';

import '../utils/api_query.dart';
import '../utils/index.dart';

/// Services that retrieves information about SpaceX's launches.
class LaunchesService extends BaseService<Dio> {
  const LaunchesService(Dio client) : super(client);

  Future<Response> getLaunches() async {
    return client.post(
      Url.launches,
      data: ApiQuery.launch,
    );
  }
}
