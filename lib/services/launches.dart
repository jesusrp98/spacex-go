import 'package:cherry/util/api_query.dart';
import 'package:dio/dio.dart';

import '../util/index.dart';
import 'index.dart';

/// Services that retrieves information about SpaceX's launches.
class LaunchesService extends BaseService {
  const LaunchesService(Dio client) : super(client);

  /// Retrieves a list of featuring information about upcoming and latest launches.
  Future<Response> getLaunches() async {
    return client.post(
      Url.launches,
      data: ApiQuery.launch,
    );
  }
}
