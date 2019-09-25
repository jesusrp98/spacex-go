import 'package:flutter/material.dart';
import 'package:row_collection/row_collection.dart';

/// Widget used in vehicle & launch lists to display items.
class ListCell extends StatelessWidget {
  final Widget leading, trailing;
  final String title, subtitle;
  final VoidCallback onTap;
  final EdgeInsets contentPadding;

  const ListCell({
    this.leading,
    this.trailing,
    @required this.title,
    this.subtitle,
    this.onTap,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 2,
      horizontal: 16,
    ),
  });

  factory ListCell.image({
    @required BuildContext context,
    @required String image,
    Widget trailing,
    @required String title,
    String subtitle,
    VoidCallback onTap,
  }) {
    return ListCell(
      leading: Image.asset(
        image,
        width: 40,
        height: 40,
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.black45
            : null,
      ),
      trailing: trailing,
      title: title,
      subtitle: subtitle,
      onTap: onTap,
    );
  }

  factory ListCell.icon({
    @required IconData icon,
    Widget trailing,
    @required String title,
    String subtitle,
    VoidCallback onTap,
  }) {
    return ListCell(
      leading: Icon(icon, size: 40),
      trailing: trailing,
      title: title,
      subtitle: subtitle,
      onTap: onTap,
    );
  }

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
              fontSize: 17,
              fontFamily: 'ProductSans',
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          if (subtitle != null) Separator.spacer(space: 4),
        ],
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle,
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'ProductSans',
                color: Theme.of(context).textTheme.caption.color,
              ),
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
  final String number;

  const MissionNumber(this.number);

  @override
  Widget build(BuildContext context) {
    return Text(
      number,
      style: TextStyle(
        fontSize: 15,
        fontFamily: 'ProductSans',
        color: Theme.of(context).textTheme.caption.color,
      ),
      textAlign: TextAlign.end,
    );
  }
}
