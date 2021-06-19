import 'package:flutter_request_bloc/flutter_request_bloc.dart';

import '../repositories/index.dart';

/// Cubit that holds information about the changelog of this app.
class ChangelogCubit
    extends RequestPersistantCubit<ChangelogRepository, String> {
  ChangelogCubit(ChangelogRepository repository) : super(repository);

  @override
  Future<void> loadData() async {
    emit(RequestState.loading(state.value));

    try {
      final data = await repository.fetchData();

      emit(RequestState.loaded(data));
    } catch (e) {
      emit(RequestState.error(e.toString()));
    }
  }
}
