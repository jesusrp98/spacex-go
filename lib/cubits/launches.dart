import '../models/index.dart';
import '../repositories-cubit/index.dart';
import 'base/index.dart';

class LaunchesCubit extends RequestCubit<LaunchesRepository, List<Launch>> {
  LaunchesCubit(LaunchesRepository repository) : super(repository);

  @override
  Future<void> loadData() async {
    emit(RequestState.loading());

    try {
      final data = await repository.fetchData();

      emit(RequestState.loaded(data));
    } catch (e) {
      emit(RequestState.error(e.toString()));
    }
  }
}
