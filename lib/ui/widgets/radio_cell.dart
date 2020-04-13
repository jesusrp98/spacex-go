import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _kRadioSize = 18.0;

///
class RadioCell<T> extends StatelessWidget {
  final String title;
  final T groupValue, value;
  final Function(T) onChanged;

  const RadioCell({
    this.title,
    this.groupValue,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        color: groupValue == value
            ? Theme.of(context).accentColor.withOpacity(0.24)
            : null,
        child: Row(
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                  height: _kRadioSize,
                  width: _kRadioSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: groupValue == value
                        ? Theme.of(context).accentColor
                        : Theme.of(context)
                            .textTheme
                            .caption
                            .color
                            .withOpacity(0.20),
                  ),
                ),
                if (groupValue == value)
                  Container(
                    height: _kRadioSize * 0.45,
                    width: _kRadioSize * 0.45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).dialogBackgroundColor,
                    ),
                  ),
              ],
            ),
            SizedBox(width: 20),
            Text(
              title,
              style: GoogleFonts.rubikTextTheme(
                Theme.of(context).textTheme,
              ).subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}
