import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:scoped_model/scoped_model.dart';

import '../util/colors.dart';

/// ROW ITEM WIDGET
/// Stretched widget to display information in a 'Card Page' widget.
/// Contains a title and a description widget, which can be an icon or a text.
class RowItem extends StatelessWidget {
  final String title;
  final Widget description;

  RowItem(this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.subhead,
          ),
          description
        ],
      ),
    );
  }

  /// Builds a normal Text-to-Text row item
  factory RowItem.textRow(
    BuildContext context,
    String title,
    String description,
  ) {
    return RowItem(title, _getText(context, description));
  }

  /// Builds a Text-to-Icon row item, to display a boolean status
  factory RowItem.iconRow(String title, bool status) {
    return RowItem(title, _getIcon(status));
  }

  /// Builds a Text-to-Text widget, but the description widget is clickable
  /// and opens a dialog
  factory RowItem.dialogRow({
    BuildContext context,
    String title,
    String description,
    ScopedModel screen,
  }) {
    return RowItem(
      title,
      AbsorbPointer(
        absorbing: description ==
            FlutterI18n.translate(context, 'spacex.other.unknown'),
        child: InkWell(
          child: _getText(
            context,
            description,
            description !=
                FlutterI18n.translate(context, 'spacex.other.unknown'),
          ),
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => screen,
                  fullscreenDialog: true,
                ),
              ),
        ),
      ),
    );
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
  static Widget _getText(BuildContext context, String description,
      [bool clickable = false]) {
    return Text(
      description,
      style: TextStyle(
        fontSize: 17.0,
        color: Theme.of(context).textTheme.caption.color,
        decoration: clickable ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}
