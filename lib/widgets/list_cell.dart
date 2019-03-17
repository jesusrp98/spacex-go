import 'package:flutter/material.dart';

import 'separator.dart';

/// LIST CELL WIDGET
/// Widget used in vehicle & launch lists to display items.
class ListCell extends StatelessWidget {
  final Widget leading, trailing;
  final String title, subtitle;
  final int maxTitleLines;
  final VoidCallback onTap;
  final EdgeInsets contentPadding;

  ListCell({
    this.leading,
    this.trailing,
    @required this.title,
    @required this.subtitle,
    this.maxTitleLines = 1,
    this.onTap,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 6,
      horizontal: 16,
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
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: maxTitleLines,
          ),
          Separator.spacer(height: 7),
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
    return Text(
      missionNumber,
      style: Theme.of(context)
          .textTheme
          .subhead
          .copyWith(color: Theme.of(context).textTheme.caption.color),
      textAlign: TextAlign.end,
    );
  }
}
