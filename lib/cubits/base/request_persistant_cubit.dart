import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../repositories/index.dart';
import 'index.dart';

abstract class RequestPersistantCubit<R extends BaseRepository>
    extends RequestCubit<R> with HydratedMixin {
  RequestPersistantCubit(R repository) : super(repository);

  @override
  RequestState fromJson(Map<String, dynamic> json) {
    return RequestState.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(RequestState state) {
    return state.toJson();
  }
}
