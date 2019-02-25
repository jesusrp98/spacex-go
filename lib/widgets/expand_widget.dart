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

/// https://stackoverflow.com/questions/54091055/flutter-how-to-get-the-number-of-text-lines
class _TextExpandState extends State<TextExpand> {
  bool _isShort = true;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      final TextPainter textPainter = TextPainter(
        text: TextSpan(text: widget.text),
        maxLines: 3,
      )..layout(maxWidth: size.maxWidth);

      final TextStyle textStyle = TextStyle(
        color: Theme.of(context).textTheme.caption.color,
        fontSize: 15,
      );

      if (textPainter.didExceedMaxLines) {
        return _isShort
            ? Column(
                children: <Widget>[
                  Text(
                    widget.text,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.fade,
                    style: textStyle,
                    maxLines: 5,
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
            : Text(widget.text, textAlign: TextAlign.justify, style: textStyle);
      } else {
        return Text(widget.text, textAlign: TextAlign.justify, style: textStyle);
      }
    });
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
