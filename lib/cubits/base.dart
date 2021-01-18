import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/index.dart';

enum Status { init, loading, loaded, error }

abstract class RequestCubit<S extends BaseService, T>
    extends Cubit<BaseState<T>> {
  final S service;

  RequestCubit(this.service) : super(BaseState.init());

  Future<void> fetchData();
}

@immutable
class BaseState<T> extends Equatable {
  final Status status;
  final T value;
  final String errorMessage;

  const BaseState._({
    this.status,
    this.value,
    this.errorMessage,
  });

  const BaseState.init()
      : this._(
          status: Status.init,
        );

  const BaseState.loading()
      : this._(
          status: Status.loading,
        );

  const BaseState.loaded(T data)
      : this._(
          status: Status.loaded,
          value: data,
        );

  const BaseState.error(String error)
      : this._(
          status: Status.error,
          errorMessage: error,
        );

  @override
  List<Object> get props => [
        status,
        value,
        errorMessage,
      ];
}
