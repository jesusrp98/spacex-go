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

  void toggleContent() => setState(() => _isHide = !_isHide);

  @override
  Widget build(BuildContext context) {
    return _isHide
        ? _ExpanderIcon.maximize(
            message: FlutterI18n.translate(
              context,
              'spacex.other.more_details',
            ),
            onTap: () => toggleContent(),
          )
        : Column(children: <Widget>[
            widget.child,
            _ExpanderIcon.minimize(
              message: FlutterI18n.translate(
                context,
                'spacex.other.more_details',
              ),
              onTap: () => toggleContent(),
            )
          ]);
  }
}

/// TEXT EXPAND WIDGET
/// Stateful widget, which when tapped, opens more details.
/// It expands a [Text] widget, maxing its [maxLines] parameter.
class TextExpand extends StatefulWidget {
  final String text;
  final int maxLength;
  final TextStyle style;

  TextExpand({
    @required this.text,
    this.maxLength = 5,
    this.style,
  });

  @override
  _TextExpandState createState() => _TextExpandState();
}

class _TextExpandState extends State<TextExpand> {
  bool _isShort = true;

  void toggleContent() => setState(() => _isShort = !_isShort);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      final TextPainter textPainter = TextPainter(
        text: TextSpan(text: widget.text),
        textDirection: TextDirection.rtl,
        maxLines: widget.maxLength,
      )..layout(maxWidth: size.maxWidth);
      final TextStyle textStyle = widget.style ??
          TextStyle(
            color: Theme.of(context).textTheme.caption.color,
            fontSize: 15,
          );

      return textPainter.didExceedMaxLines
          ? Column(children: <Widget>[
              Text(
                widget.text,
                textAlign: TextAlign.justify,
                overflow: TextOverflow.fade,
                style: textStyle,
                maxLines: _isShort ? widget.maxLength : null,
              ),
              _isShort
                  ? _ExpanderIcon.maximize(
                      message: FlutterI18n.translate(
                        context,
                        'spacex.other.more_details',
                      ),
                      onTap: () => toggleContent(),
                    )
                  : _ExpanderIcon.minimize(
                      message: FlutterI18n.translate(
                        context,
                        'spacex.other.more_details',
                      ),
                      onTap: () => toggleContent(),
                    )
            ])
          : Text(
              widget.text,
              textAlign: TextAlign.justify,
              style: textStyle,
            );
    });
  }
}

/// EXPAND ICON WIDGET
/// Auxiliary widget with allows user to expand a widget.
class _ExpanderIcon extends StatelessWidget {
  final IconData icon;
  final String message;
  final VoidCallback onTap;

  _ExpanderIcon({
    @required this.icon,
    @required this.message,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: InkResponse(
        child: Icon(icon, color: Theme.of(context).textTheme.caption.color),
        onTap: onTap,
      ),
    );
  }

  factory _ExpanderIcon.maximize({String message, VoidCallback onTap}) {
    return _ExpanderIcon(
      icon: Icons.expand_more,
      message: message,
      onTap: onTap,
    );
  }

  factory _ExpanderIcon.minimize({String message, VoidCallback onTap}) {
    return _ExpanderIcon(
      icon: Icons.expand_less,
      message: message,
      onTap: onTap,
    );
  }
}
