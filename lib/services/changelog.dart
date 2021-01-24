import 'package:dio/dio.dart';

import '../util/index.dart';
import 'index.dart';

/// Services that retrieves information about the app's changelog.
class ChangelogService extends BaseService<Dio> {
  const ChangelogService(Dio client) : super(client);

  Future<Response> getChangelog() async {
    return client.get(Url.changelog);
  }
}
