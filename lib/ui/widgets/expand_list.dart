import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';

///
class ExpandList extends StatelessWidget {
  final Widget child;
  final String text;

  const ExpandList({
    Key key,
    @required this.child,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandChild(
      expandArrowStyle: ExpandArrowStyle.text,
      hideArrowOnExpanded: true,
      collapsedHint: text,
      hintTextStyle: Theme.of(context).textTheme.bodyText2.copyWith(
            color: Theme.of(context).textTheme.caption.color,
          ),
      child: child,
    );
  }
}
