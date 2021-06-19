import 'package:flutter_request_bloc/flutter_request_bloc.dart';

import '../models/index.dart';
import '../services/index.dart';

/// Handles retrieve and transformation of [Achievement] from the API.
class AchievementsRepository
    extends BaseRepository<AchievementsService, List<Achievement>> {
  AchievementsRepository(AchievementsService service) : super(service);

  @override
  Future<List<Achievement>> fetchData() async {
    final response = await service.getAchievements();

    return [for (final item in response.data) Achievement.fromJson(item)];
  }
}
