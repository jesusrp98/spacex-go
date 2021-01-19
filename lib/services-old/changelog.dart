import 'package:dio/dio.dart';

import '../util/index.dart';
import 'index.dart';

/// Services that retrieves information about the app's changelog.
class ChangelogService extends BaseService {
  const ChangelogService(Dio client) : super(client);

  /// Retrieves cherry's changelog file from GitHub.
  Future<Response> getChangelog() async {
    return client.get(Url.changelog);
  }
}
