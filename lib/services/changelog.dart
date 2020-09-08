import 'package:dio/dio.dart';

import '../util/index.dart';
import 'index.dart';

/// TODO
class ChangelogService extends BaseService {
  const ChangelogService(Dio client) : super(client);

  /// Retrieves cherry's changelog file from GitHub.
  Future<Response> getChangelog() async {
    return client.get(Url.changelog);
  }
}
