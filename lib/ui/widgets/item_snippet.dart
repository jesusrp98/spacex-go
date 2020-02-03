import 'package:flutter/material.dart';
import 'package:row_collection/row_collection.dart';

/// Shows information rendering a small clickable widget.
/// You can use the [icon] and [text] properties to display the info.
class ItemSnippet extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onTap;

  const ItemSnippet({
    Key key,
    this.icon,
    this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            icon,
            size: 16,
            color: Theme.of(context).textTheme.caption.color,
          ),
          Separator.spacer(space: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'ProductSans',
              color: Theme.of(context).textTheme.caption.color,
              decoration: onTap == null
                  ? TextDecoration.none
                  : TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
