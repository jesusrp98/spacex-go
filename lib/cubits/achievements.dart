import '../models/index.dart';
import '../services/index.dart';
import 'base/index.dart';

class AchievementsCubit
    extends RequestCubit<AchievementsService, List<Achievement>> {
  AchievementsCubit(AchievementsService service) : super(service);

  @override
  Future<void> fetchData() async {
    emit(RequestState.loading());

    try {
      final response = await service.getAchievements();
      final data = [
        for (final item in response.data) Achievement.fromJson(item)
      ];

      emit(RequestState.loaded(data));
    } catch (e) {
      emit(RequestState.error(e));
    }
  }
}
