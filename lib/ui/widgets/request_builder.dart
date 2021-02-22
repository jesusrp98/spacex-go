import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/base/index.dart';

typedef RequestWidgetBuilder<T> = Widget Function(
  BuildContext context,
  RequestState<T> state,
);

typedef RequestWidgetBuilderLoaded<T> = Widget Function(
  BuildContext context,
  RequestState<T> state,
  T value,
);

typedef RequestListBuilderLoaded<T> = List<Widget> Function(
  BuildContext context,
  RequestState<T> state,
  T value,
);

typedef RequestWidgetBuilderError<T> = Widget Function(
  BuildContext context,
  RequestState<T> state,
  String errorMessage,
);

typedef RequestListBuilderError<T> = List<Widget> Function(
  BuildContext context,
  RequestState<T> state,
  String errorMessage,
);

class RequestBuilder<C extends RequestCubit, T> extends StatelessWidget {
  final RequestWidgetBuilder<T> onInit;
  final RequestWidgetBuilderLoaded<T> onLoading;
  final RequestWidgetBuilderLoaded<T> onLoaded;
  final RequestWidgetBuilderError<T> onError;

  const RequestBuilder({
    Key key,
    this.onInit,
    this.onLoading,
    this.onLoaded,
    this.onError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<C, RequestState>(
      listener: (context, state) => null,
      builder: (context, state) {
        switch (state.status) {
          case RequestStatus.init:
            if (onInit != null) return onInit(context, state);
            break;

          case RequestStatus.loading:
            if (onLoading != null) {
              return onLoading(context, state, state.value);
            }
            break;

          case RequestStatus.loaded:
            if (onLoaded != null) return onLoaded(context, state, state.value);
            break;

          case RequestStatus.error:
            if (onError != null) {
              return onError(context, state, state.errorMessage);
            }
            break;
        }

        return SizedBox();
      },
    );
  }
}
