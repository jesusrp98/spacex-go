import 'package:dio/dio.dart';

import '../util/api_query.dart';
import '../util/index.dart';
import 'index.dart';

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
