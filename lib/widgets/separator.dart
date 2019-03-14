import 'package:flutter/material.dart';

/// SEPARATOR WIDGET
/// Auxiliary widget used to separate other widgets.
class Separator extends StatelessWidget {
  final Widget body;

  Separator(this.body);

  @override
  Widget build(BuildContext context) {
    return body;
  }

  /// Normal spacer
  factory Separator.spacer({double height = 14, double width = 0}) {
    return Separator(SizedBox(height: height, width: width));
  }

  /// Card-only spacer
  factory Separator.cardSpacer() {
    return Separator(SizedBox(height: 8));
  }

  /// It's a simple divider, you know
  factory Separator.divider({double height = 28, double indent = 0}) {
    return Separator(Divider(height: height, indent: indent));
  }

  /// Empty widget
  factory Separator.none() {
    return Separator(SizedBox());
  }
}
