import 'package:flutter/material.dart';
import 'package:row_item/row_item.dart';

import '../../utils/translate.dart';

/// Wrapper on [RowItem.tap]. Handles the behaviour of not having a description
/// and tap callback by using a differrent text style & data.
class RowTap extends StatelessWidget {
  final String title, description, fallback;
  final VoidCallback onTap;

  const RowTap(
    this.title,
    this.description, {
    Key key,
    @required this.onTap,
    this.fallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RowItem.tap(
      title,
      description ?? fallback ?? context.translate('spacex.other.unknown'),
      descriptionStyle: TextStyle(
        decoration: description != null
            ? TextDecoration.underline
            : TextDecoration.none,
      ),
      onTap: description == null ? null : onTap,
    );
  }
}
