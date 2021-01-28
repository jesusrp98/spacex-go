import 'package:flutter/material.dart';

/// TODO
class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: const CircularProgressIndicator(),
    );
  }
}

/// TODO
class LoadingSliverView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: LoadingView(),
    );
  }
}
