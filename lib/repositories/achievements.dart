import 'package:cherry/models/index.dart';
import 'package:cherry/services/index.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';

/// Handles retrieve and transformation of [Achievement] from the API.
class AchievementsRepository
    extends RequestRepository<AchievementsService, List<Achievement>> {
  AchievementsRepository(super.service);

  @override
  Future<List<Achievement>> fetchData() async {
    final response = await service.getAchievements();

    return [for (final item in response.data) Achievement.fromJson(item)];
  }
}
