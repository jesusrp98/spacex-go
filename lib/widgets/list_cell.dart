import 'package:flutter/material.dart';

import 'separator.dart';

/// LIST CELL WIDGET
/// Widget used in vehicle & launch lists to display items.
class ListCell extends StatelessWidget {
  final Widget leading, trailing;
  final String title, subtitle;
  final VoidCallback onTap;
  final EdgeInsets contentPadding;

  ListCell({
    this.leading,
    this.trailing,
    this.title,
    this.subtitle,
    this.onTap,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 16.0,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Separator.spacer(height: 6.0),
        ],
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context)
            .textTheme
            .subhead
            .copyWith(color: Theme.of(context).textTheme.caption.color),
      ),
      trailing: trailing,
      contentPadding: contentPadding,
      onTap: onTap,
    );
  }
}

/// MISSION NUMBER WIDGET
/// Trailing widget which displays the number of a specific mission.
class MissionNumber extends StatelessWidget {
  final String missionNumber;

  MissionNumber(this.missionNumber);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: Text(
        missionNumber,
        style: Theme.of(context)
            .textTheme
            .subhead
            .copyWith(fontSize: 18.0, color: Theme.of(context).textTheme.caption.color),
        textAlign: TextAlign.center,
      ),
    );
  }
}
