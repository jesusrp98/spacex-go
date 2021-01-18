import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/index.dart';
import 'index.dart';

abstract class RequestCubit<S extends BaseService, T>
    extends Cubit<RequestState<T>> {
  final S service;

  RequestCubit(this.service)
      : assert(service != null),
        super(RequestState.init());

  Future<void> fetchData();
}
