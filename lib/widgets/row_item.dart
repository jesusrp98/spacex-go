import 'package:flutter/material.dart';

import '../colors.dart';
import 'details_dialog.dart';

/// ROW ITEM CLASS
/// Class to build a stretched widget to display information in a
/// Card Page widget.
/// Contains a title and a description widget, which can be an icon or a text.
class RowItem extends StatelessWidget {
  final String title;
  final Widget description;

  RowItem({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: primaryText),
          ),
          description
        ],
      ),
    );
  }

  /// Builds a normal Text-to-Text row item
  factory RowItem.textRow(String title, String description) {
    return RowItem(title: title, description: _getText(description));
  }

  /// Builds a Text-to-Icon row item, to display a boolean status
  factory RowItem.iconRow(String title, bool status) {
    return RowItem(title: title, description: _getIcon(status));
  }

  /// Builds a Text-to-Text widget, but the description widget is clickable
  /// and opens a dialog
  factory RowItem.dialogRow(
    BuildContext context,
    String title,
    String description,
    DetailsDialog dialog,
  ) {
    if (description != 'Unknown')
      return RowItem(
        title: title,
        description: _getDialog(context, dialog, description),
      );
    else
      return RowItem(title: title, description: _getText(description));
  }

  /// Return an icon based on the [status] var
  static Widget _getIcon(bool status) {
    return Icon(
      status == null
          ? Icons.remove_circle
          : (status ? Icons.check_circle : Icons.cancel),
      color: status == null ? nullIcon : (status ? acceptIcon : denyIcon),
      size: 19.0,
    );
  }

  /// Returns a text description
  static Widget _getText(String description, [bool clickable = false]) {
    return Text(
      description,
      style: TextStyle(
        fontSize: 17.0,
        color: secondaryText,
        decoration: clickable ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }

  /// Builds a dialog with the Details Dialog class
  static _getDialog(
    BuildContext context,
    DetailsDialog dialog,
    String description,
  ) {
    return InkWell(
      child: _getText(description, true),
      onTap: () => showDialog(context: context, builder: (_) => dialog),
    );
  }
}
