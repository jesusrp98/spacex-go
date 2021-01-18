import '../services/index.dart';
import 'index.dart';

class ChangelogCubit extends RequestCubit<ChangelogService, String> {
  ChangelogCubit(ChangelogService service) : super(service);

  @override
  Future<void> fetchData() async {
    emit(BaseState.loading());

    try {
      final response = await service.getChangelog();
      final data = response.data;

      emit(BaseState.loaded(data));
    } catch (e) {
      emit(BaseState.error(e));
    }
  }
}
