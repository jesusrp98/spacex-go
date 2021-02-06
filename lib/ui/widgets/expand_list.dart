import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';

/// Wrapper on [ExpandChild]. It expands a widget, and then it hides
/// the expanding arrow.
class ExpandList extends StatelessWidget {
  final Widget child;
  final String hint;

  const ExpandList({
    Key key,
    @required this.child,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandChild(
      expandArrowStyle: ExpandArrowStyle.text,
      hideArrowOnExpanded: true,
      collapsedHint: hint,
      child: child,
    );
  }
}
