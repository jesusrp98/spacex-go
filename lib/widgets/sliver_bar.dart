import 'package:flutter/material.dart';

/// SLIVER BAR WIDGET
/// Custom sliver app bar used in Sliver views.
/// It collapses when user scrolls down.
class SliverBar extends StatelessWidget {
  final Widget title, header;
  final num height;
  final List<Widget> actions;

  SliverBar({
    this.title,
    this.header,
    this.height = 0.3,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * height,
      actions: actions,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: title,
        background: header,
      ),
    );
  }
}
