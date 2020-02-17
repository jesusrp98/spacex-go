import 'package:big_tip/big_tip.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BigTip(
        title: 'An error ocurred',
        subtitle: 'This page is not available',
        child: Icon(Icons.sentiment_very_dissatisfied),
      ),
    );
  }
}
