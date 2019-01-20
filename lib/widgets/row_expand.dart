import 'package:flutter/material.dart';

import '../util/colors.dart';
import 'separator.dart';

class RowExpand extends StatefulWidget {
  final Widget child;

  RowExpand(this.child);

  @override
  _RowExpandState createState() => _RowExpandState();
}

class _RowExpandState extends State<RowExpand> {
  bool _isHide = true;

  @override
  Widget build(BuildContext context) {
    return _isHide
        ? InkWell(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.expand_more, size: 19.0),
                  Separator.spacer(width: 4.0),
                  Text(
                    'Show more details',
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(color: primaryText),
                  )
                ],
              ),
            ),
            onTap: () => setState(() => _isHide = false),
          )
        : widget.child;
  }
}
