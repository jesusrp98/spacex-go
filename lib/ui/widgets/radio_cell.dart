import 'package:flutter/material.dart';

/// Wrapper widget used in the [SettingsScreen] screen.
/// Used to add custom styling easily to [RadioListTile] widget.
class RadioCell<T> extends StatelessWidget {
  final String title;
  final T groupValue, value;
  final Function(T) onChanged;

  const RadioCell({
    this.title,
    this.groupValue,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      title: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
      dense: true,
      groupValue: groupValue,
      activeColor: Theme.of(context).accentColor,
      value: value,
      onChanged: onChanged,
    );
  }
}
