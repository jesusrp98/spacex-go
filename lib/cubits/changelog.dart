import '../repositories/index.dart';
import 'base/index.dart';

class ChangelogCubit
    extends RequestPersistantCubit<ChangelogRepository, String> {
  ChangelogCubit(ChangelogRepository service) : super(service);

  @override
  Future<void> loadData() async {
    emit(RequestState.loading());

    try {
      final data = await repository.fetchData();

      emit(RequestState.loaded(data));
    } catch (e) {
      emit(RequestState.error(e));
    }
  }
}
