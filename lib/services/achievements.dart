import 'package:dio/dio.dart';

import '../util/index.dart';
import 'index.dart';

/// Services that retrieves a list featuring the latest SpaceX acomplishments.
class AchievementsService extends BaseService<Dio> {
  const AchievementsService(Dio client) : super(client);

  Future<Response> getAchievements() async {
    return client.get(Url.companyAchievements);
  }
}
