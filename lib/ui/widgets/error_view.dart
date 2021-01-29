import 'package:big_tip/big_tip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:google_fonts/google_fonts.dart';

/// TODO
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
        style:
            GoogleFonts.rubikTextTheme(Theme.of(context).textTheme).subtitle1,
      ),
      action: Text(
        FlutterI18n.translate(
          context,
          'spacex.other.loading_error.reload',
        ),
        style: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme)
            .subtitle1
            .copyWith(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
            ),
      ),
      actionCallback: onRefresh,
      child: Icon(Icons.cloud_off),
    );
  }
}

/// TODO
class ErrorSliverView extends StatelessWidget {
  final void Function() onRefresh;

  const ErrorSliverView(this.onRefresh, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: BigTip(
        subtitle: Text(
          FlutterI18n.translate(
            context,
            'spacex.other.loading_error.message',
          ),
          style:
              GoogleFonts.rubikTextTheme(Theme.of(context).textTheme).subtitle1,
        ),
        action: Text(
          FlutterI18n.translate(
            context,
            'spacex.other.loading_error.reload',
          ),
          style: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme)
              .subtitle1
              .copyWith(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        actionCallback: onRefresh,
        child: Icon(Icons.cloud_off),
      ),
    );
  }
}
