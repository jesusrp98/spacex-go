import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum RequestStatus { init, loading, loaded, error }

@immutable
class RequestState<T> extends Equatable {
  final RequestStatus status;
  final T value;
  final String errorMessage;

  const RequestState._({
    this.status,
    this.value,
    this.errorMessage,
  });

  factory RequestState.fromJson(Map<String, dynamic> json) {
    return RequestState._(
      status: json['status'],
      value: json['value'],
      errorMessage: json['errorMessage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'value': value,
      'errorMessage': errorMessage,
    };
  }

  const RequestState.init()
      : this._(
          status: RequestStatus.init,
        );

  const RequestState.loading()
      : this._(
          status: RequestStatus.loading,
        );

  const RequestState.loaded(T data)
      : this._(
          status: RequestStatus.loaded,
          value: data,
        );

  const RequestState.error(String error)
      : this._(
          status: RequestStatus.error,
          errorMessage: error,
        );

  @override
  List<Object> get props => [
        status,
        value,
        errorMessage,
      ];
}
