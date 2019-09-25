import 'package:flutter/material.dart';

/// Custom sliver app bar used in Sliver views.
/// It collapses when user scrolls down.
class SliverBar extends StatelessWidget {
  static const double heightRatio = 0.3;

  final String title;
  final Widget header;
  final num height;
  final List<Widget> actions;

  const SliverBar({
    this.title,
    this.header,
    this.height = heightRatio,
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
        // Using title constraining, because Flutter doesn't do this automatically.
        // Open issue: [https://github.com/flutter/flutter/issues/14227]
        title: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.55,
          ),
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: TextStyle(
              fontFamily: 'ProductSans',
              shadows: <Shadow>[
                Shadow(
                  offset: const Offset(0, 0),
                  blurRadius: 4,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
        background: header,
      ),
    );
  }
}
