import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

/// Wrapper of the [ExpandChild] widget.
class RowExpand extends StatelessWidget {
  final Widget child;

  const RowExpand(this.child);

  @override
  Widget build(BuildContext context) {
    return ExpandChild(
      minMessage: FlutterI18n.translate(
        context,
        'spacex.other.more_details',
      ),
      maxMessage: FlutterI18n.translate(
        context,
        'spacex.other.less_details',
      ),
      child: child,
    );
  }
}

/// Wrapper of the [ExpandText] widget.
class TextExpand extends StatelessWidget {
  final String text;
  final int lines;

  const TextExpand(this.text, {this.lines = 8});

  factory TextExpand.small(String text) {
    return TextExpand(text, lines: 6);
  }

  @override
  Widget build(BuildContext context) {
    return ExpandText(
      text,
      maxLength: lines,
      textAlign: TextAlign.justify,
      style: TextStyle(
        color: Theme.of(context).textTheme.caption.color,
        fontSize: 15,
      ),
    );
  }
}

/// Wrapper of the [ShowChild] widget.
class ExpandList extends StatelessWidget {
  final Widget child;

  const ExpandList(this.child);

  @override
  Widget build(BuildContext context) {
    return ShowChild(
      indicator: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          FlutterI18n.translate(
            context,
            'spacex.other.all_payload',
          ),
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'ProductSans',
            color: Theme.of(context).textTheme.caption.color,
          ),
        ),
      ),
      child: child,
    );
  }
}
