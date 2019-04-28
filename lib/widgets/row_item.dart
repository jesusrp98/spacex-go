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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Text(
            title,
            style: TextStyle(fontSize: 15),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        Expanded(
          flex: 6,
          child: Align(
            alignment: Alignment.centerRight,
            child: description,
          ),
        ),
      ],
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
        child: InkResponse(
          child: _getText(
            context,
            description,
            description !=
                FlutterI18n.translate(context, 'spacex.other.unknown'),
          ),
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => screen,
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
          ? Icons.help
          : (status ? Icons.check_circle : Icons.cancel),
      color: status == null ? nullIcon : (status ? acceptIcon : denyIcon),
      size: 18,
    );
  }

  /// Returns a text description
  static Widget _getText(
    BuildContext context,
    String description, [
    bool clickable = false,
  ]) {
    return Text(
      description,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      textAlign: TextAlign.end,
      style: TextStyle(
        fontSize: 15,
        color: Theme.of(context).textTheme.caption.color,
        decoration: clickable ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}
