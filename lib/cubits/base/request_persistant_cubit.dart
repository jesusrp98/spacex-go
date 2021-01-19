import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../repositories-cubit/base/index.dart';
import 'index.dart';

abstract class RequestPersistantCubit<R extends RequestRepository<T>, T>
    extends RequestCubit<R, T> with HydratedMixin {
  RequestPersistantCubit(R repository) : super(repository);

  @override
  RequestState<T> fromJson(Map<String, dynamic> json) {
    return RequestState.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(RequestState<T> state) {
    return state.toJson();
  }
}
