import '../services/index.dart';
import 'base/index.dart';

class ChangelogCubit extends RequestCubit<ChangelogService, String> {
  ChangelogCubit(ChangelogService service) : super(service);

  @override
  Future<void> fetchData() async {
    emit(RequestState.loading());

    try {
      final response = await service.getChangelog();
      final data = response.data;

      emit(RequestState.loaded(data));
    } catch (e) {
      emit(RequestState.error(e));
    }
  }
}
