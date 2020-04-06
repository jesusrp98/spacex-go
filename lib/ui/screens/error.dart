import 'package:big_tip/big_tip.dart';
import 'package:flutter/material.dart';

/// Screen that is displayed when the routing system
/// throws an error (404 screen).
class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BigTip(
        title: 'An error ocurred',
        subtitle: 'This page is not available',
        action: 'GO BACK',
        actionCallback: () => Navigator.pop(context),
        child: Icon(Icons.error_outline),
      ),
    );
  }
}
