import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// This widget is used in the 'Settings' & 'About' screens.
/// It categorizes items based on a theme.
class HeaderText extends StatelessWidget {
  final String text;

  const HeaderText(this.text);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: EdgeInsets.only(left: 16, top: 16),
      child: Padding(
        padding: EdgeInsets.zero,
        child: Text(
          text,
          style: GoogleFonts.varelaRound(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
