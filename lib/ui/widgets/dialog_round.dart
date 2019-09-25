import 'package:flutter/material.dart';

/// Custom SimpleDialog widget, with a preset title style.
/// It also has, as its name suggets, rounded corners.
class RoundDialog extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const RoundDialog({
    @required this.title,
    @required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'ProductSans',
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      children: children,
    );
  }
}
