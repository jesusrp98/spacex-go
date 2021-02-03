import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../repositories/index.dart';
import 'index.dart';

/// Cubit that extends on [RequestCubit] by adding the ability to store its
/// internal state using [HydratedBloc]. Serialization is handled automatically
/// by the state and the cubit state.
///
/// Parameters:
/// - R: repository that extends [BaseRepository].
/// - T: model which represents the type of the state.
abstract class RequestPersistantCubit<R extends BaseRepository, T>
    extends RequestCubit<R, T> with HydratedMixin {
  RequestPersistantCubit(R repository) : super(repository) {
    hydrate();
  }

  @override
  RequestState<T> fromJson(Map<String, dynamic> json) {
    return RequestState<T>.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(RequestState<T> state) {
    return state.toJson();
  }
}
