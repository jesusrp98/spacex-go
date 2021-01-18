import '../models/index.dart';
import '../services/index.dart';
import 'base/index.dart';

class LaunchesCubit extends RequestCubit<LaunchesService, List<Launch>> {
  LaunchesCubit(LaunchesService service) : super(service);

  @override
  Future<void> fetchData() async {
    emit(RequestState.loading());

    try {
      final response = await service.getLaunches();
      final data = [
        for (final item in response.data['docs']) Launch.fromJson(item)
      ];

      emit(RequestState.loaded(data));
    } catch (e) {
      emit(RequestState.error(e));
    }
  }
}
