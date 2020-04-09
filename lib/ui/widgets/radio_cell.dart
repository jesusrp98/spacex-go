import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        style: GoogleFonts.rubikTextTheme(
          Theme.of(context).textTheme,
        ).subtitle1,
      ),
      dense: true,
      groupValue: groupValue,
      activeColor: Theme.of(context).accentColor,
      value: value,
      onChanged: onChanged,
    );
  }
}
