import 'package:flutter/material.dart';
import 'package:row_item/row_item.dart';

///
class RowTap extends StatelessWidget {
  final String title, description, fallback;
  final Function onTap;

  const RowTap(
    this.title,
    this.description, {
    Key key,
    @required this.fallback,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RowItem.tap(
      title,
      description ?? fallback,
      titleStyle: Theme.of(context).textTheme.bodyText2,
      descriptionStyle: Theme.of(context).textTheme.bodyText2.copyWith(
            color: Theme.of(context).textTheme.caption.color,
            decoration: description != null
                ? TextDecoration.underline
                : TextDecoration.none,
          ),
      onTap: description == null ? null : onTap,
    );
  }
}
