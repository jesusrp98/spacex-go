import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../services/base.dart';
import 'index.dart';

abstract class RequestPersistantCubit<S extends BaseService, T>
    extends RequestCubit<S, T> with HydratedMixin {
  RequestPersistantCubit(S service) : super(service);

  @override
  RequestState<T> fromJson(Map<String, dynamic> json) {
    return RequestState<T>.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(RequestState<T> state) {
    return state.toJson();
  }
}
