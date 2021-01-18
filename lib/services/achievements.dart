import 'package:dio/dio.dart';

import '../util/index.dart';
import 'index.dart';

/// Services that retrieves a list featuring the latest SpaceX acomplishments.
class AchievementsService extends BaseService {
  const AchievementsService(Dio client) : super(client);

  /// Retrieves a list featuring the latest SpaceX acomplishments.
  Future<Response> getAchievements() async {
    return client.get(Url.companyAchievements);
  }
}
