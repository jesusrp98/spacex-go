import 'package:dio/dio.dart';

import '../util/index.dart';
import 'base/index.dart';

class ChangelogRepository extends RequestRepository<String> {
  const ChangelogRepository(Dio client) : super(client);

  @override
  Future<String> fetchData() async {
    final response = await client.get(Url.changelog);
    return response.data;
  }
}
