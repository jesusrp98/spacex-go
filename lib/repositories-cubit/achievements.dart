import 'package:dio/dio.dart';

import '../models/index.dart';
import '../util/index.dart';
import 'base/index.dart';

class AchievementsRepository extends RequestRepository<List<Achievement>> {
  AchievementsRepository(Dio client) : super(client);

  @override
  Future<List<Achievement>> fetchData() async {
    final response = await client.get(Url.companyAchievements);

    return [for (final item in response.data) Achievement.fromJson(item)];
  }
}
