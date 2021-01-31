import 'package:big_tip/big_tip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

/// Widget that tells the user that there's been an error in a network process.
/// It allows the user to perform a reload action.
class ErrorView extends StatelessWidget {
  final void Function() onRefresh;

  const ErrorView(this.onRefresh, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BigTip(
      subtitle: Text(
        FlutterI18n.translate(
          context,
          'spacex.other.loading_error.message',
        ),
        style: Theme.of(context).textTheme.subtitle1,
      ),
      action: Text(
        FlutterI18n.translate(
          context,
          'spacex.other.loading_error.reload',
        ),
        style: Theme.of(context).textTheme.subtitle1.copyWith(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
            ),
      ),
      actionCallback: onRefresh,
      child: Icon(Icons.cloud_off),
    );
  }
}

/// Presents the `ErrorView` widget inside a slivered widget.
///
/// Tells the user that there's been an error in a network process.
/// It allows the user to perform a reload action.
class ErrorSliverView extends StatelessWidget {
  final void Function() onRefresh;

  const ErrorSliverView(this.onRefresh, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: ErrorView(onRefresh),
    );
  }
}
