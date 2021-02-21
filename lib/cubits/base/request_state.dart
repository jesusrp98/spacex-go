import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// Variable that represents the current state of the response operation.
enum RequestStatus { init, loading, loaded, error }

@immutable

/// Class that handles state, value and possible errors generated during a
/// network data transmission.
///
/// Parameters:
/// - T: model which represents the type of the state.
class RequestState<T> extends Equatable {
  /// Variable that represents the current state of the response operation
  final RequestStatus status;

  /// Storages the current value of the operation. Its type is defined by
  /// the class itself.
  final T value;

  /// Variable which stores possible error messages during network operations
  final String errorMessage;

  const RequestState._({
    this.status,
    this.value,
    this.errorMessage,
  });

  /// Handles creation of network request state from a JSON ([Map])
  factory RequestState.fromJson(Map<String, dynamic> json) {
    return RequestState._(
      status: RequestStatus.values[json['status']],
      value: json['value'],
      errorMessage: json['errorMessage'],
    );
  }

  /// Handles creation of JSON ([Map]) objects from a network request state
  Map<String, dynamic> toJson() {
    return {
      'status': status.index,
      'value': value,
      'errorMessage': errorMessage,
    };
  }

  /// Initial state. It doesn't stores anykind of data or error message.
  const RequestState.init()
      : this._(
          status: RequestStatus.init,
        );

  /// Loading state, between initialization & data.
  /// It also receives the previous value if available.
  const RequestState.loading([T previousValue])
      : this._(
          value: previousValue,
          status: RequestStatus.loading,
        );

  /// The request has been completed, and data has been received from the service.
  /// Data's type is checked.
  const RequestState.loaded(T data)
      : this._(
          status: RequestStatus.loaded,
          value: data,
        );

  /// An error has been generated in the network request process
  /// The error message is saved inside the [errorMessage] variable.
  const RequestState.error(String error)
      : this._(
          status: RequestStatus.error,
          errorMessage: error,
        );

  @override
  List<Object> get props => [
        status.index,
        value.toString(),
        errorMessage,
      ];

  @override
  String toString() => '($status: $value, $errorMessage)';
}
