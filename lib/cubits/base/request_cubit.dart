import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories-cubit/index.dart';
import 'index.dart';

abstract class RequestCubit<R extends BaseRepository, T>
    extends Cubit<RequestState<T>> {
  final R repository;

  RequestCubit(this.repository)
      : assert(repository != null),
        super(RequestState.init());

  Future<void> loadData();
}
