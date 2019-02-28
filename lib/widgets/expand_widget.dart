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

/// TEXT EXPAND WIDGET
/// Stateful widget, which when tapped, opens more details.
/// It expands a [Text] widget, maxing its [maxLines] parameter.
class TextExpand extends StatefulWidget {
  final String text;
  final int maxLength;
  final TextStyle style;

  TextExpand({this.text, this.maxLength, this.style});

  @override
  _TextExpandState createState() => _TextExpandState();
}

class _TextExpandState extends State<TextExpand> {
  bool _isShort = true;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      final TextPainter textPainter = TextPainter(
        text: TextSpan(text: widget.text),
        textDirection: TextDirection.rtl,
        maxLines: widget.maxLength,
      )..layout(maxWidth: size.maxWidth);

      return textPainter.didExceedMaxLines && _isShort
          ? Column(children: <Widget>[
              Text(
                widget.text,
                textAlign: TextAlign.justify,
                overflow: TextOverflow.fade,
                style: widget.style,
                maxLines: widget.maxLength,
              ),
              _ExpanderIcon(
                message: FlutterI18n.translate(
                  context,
                  'spacex.other.more_details',
                ),
                onTap: () => setState(() => _isShort = false),
              )
            ])
          : Text(
              widget.text,
              textAlign: TextAlign.justify,
              style: widget.style,
            );
    });
  }
}

/// EXPAND ICON WIDGET
/// Auxiliary widget with allows user to expand a widget.
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
