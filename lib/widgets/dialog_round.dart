import 'package:flutter/material.dart';

/// ROUND DIALOG WIDGET
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
        style: Theme.of(context)
            .textTheme
            .title
            .copyWith(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      children: children,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
