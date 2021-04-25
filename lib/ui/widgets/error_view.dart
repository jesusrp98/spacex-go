import 'package:big_tip/big_tip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';

import '../../utils/index.dart';

/// Widget that tells the user that there's been an error in a network process.
/// It allows the user to perform a reload action.
class ErrorView<C extends RequestCubit> extends StatelessWidget {
  const ErrorView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BigTip(
      subtitle: Text(
        context.translate('spacex.other.loading_error.message'),
        style: Theme.of(context).textTheme.subtitle1,
      ),
      action: Text(
        context.translate('spacex.other.loading_error.reload'),
        style: Theme.of(context).textTheme.subtitle1.copyWith(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
            ),
      ),
      actionCallback: () => context.read<C>().loadData(),
      child: Icon(Icons.cloud_off),
    );
  }
}

/// Presents the `ErrorView` widget inside a slivered widget.
///
/// Tells the user that there's been an error in a network process.
/// It allows the user to perform a reload action.
class ErrorSliverView<C extends RequestCubit> extends StatelessWidget {
  const ErrorSliverView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: ErrorView<C>(),
    );
  }
}
