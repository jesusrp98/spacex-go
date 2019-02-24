import 'package:flutter/material.dart';

class SliverBar extends StatelessWidget {
  final Widget title, header;
  final List<Widget> actions;

  SliverBar({this.title, this.header, this.actions});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.3,
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
