import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

/// ROW EXPAND WIDGET
/// Stateful widget, which when tapped, opens more details.
/// Those details are specified in the [child] variable.
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
        ? _ExpanderIcon(
            message: FlutterI18n.translate(
              context,
              'spacex.other.more_details',
            ),
            onTap: () => setState(() => _isHide = false),
          )
        : widget.child;
  }
}

class TextExpand extends StatefulWidget {
  final String text;

  TextExpand(this.text);

  @override
  _TextExpandState createState() => _TextExpandState();
}

class _TextExpandState extends State<TextExpand> {
  bool _isShort = true;

  @override
  Widget build(BuildContext context) {
    return _isShort
        ? Column(
            children: <Widget>[
              Text(
                widget.text,
                textAlign: TextAlign.justify,
                overflow: TextOverflow.fade,
                maxLines: 5,
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).textTheme.caption.color,
                ),
              ),
              _ExpanderIcon(
                message: FlutterI18n.translate(
                  context,
                  'spacex.other.more_details',
                ),
                onTap: () => setState(() => _isShort = false),
              )
            ],
          )
        : Text(
            widget.text,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).textTheme.caption.color,
            ),
          );
  }
}

class _ExpanderIcon extends StatelessWidget {
  final String message;
  final VoidCallback onTap;

  _ExpanderIcon({this.message, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: InkResponse(
        child: Icon(
          Icons.expand_more,
          color: Theme.of(context).textTheme.caption.color,
        ),
        onTap: onTap,
      ),
    );
  }
}
