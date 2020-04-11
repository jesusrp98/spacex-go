import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// This widget is used in the 'Settings' & 'About' screens.
/// It categorizes items based on a theme.
class HeaderText extends StatelessWidget {
  final String text;
  final bool head;

  const HeaderText(this.text, {this.head = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: EdgeInsets.only(left: 16, top: head ? 16 : 0),
      child: Padding(
        padding: EdgeInsets.zero,
        child: Text(
          text,
          style: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme)
              .bodyText2
              .copyWith(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
