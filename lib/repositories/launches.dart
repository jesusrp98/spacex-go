import 'package:dio/dio.dart';

import '../models/index.dart';
import '../util/index.dart';
import 'base/index.dart';

class LaunchesRepository extends RequestRepository<List<Launch>> {
  LaunchesRepository(Dio client) : super(client);

  @override
  Future<List<Launch>> fetchData() async {
    final response = await client.post(
      Url.launches,
      data: ApiQuery.launch,
    );

    return [for (final item in response.data['docs']) Launch.fromJson(item)];
  }
}
