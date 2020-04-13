import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:row_collection/row_collection.dart';

/// Custom SimpleDialog widget, with a preset title style.
/// It also has, as its name suggets, rounded corners.
class RoundDialog extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const RoundDialog({
    @required this.title,
    @required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        title.toUpperCase(),
        style: GoogleFonts.rubikTextTheme(
          Theme.of(context).textTheme,
        ).headline6,
        textAlign: TextAlign.center,
      ),
      titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20),
      contentPadding: EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      children: children,
    );
  }
}

///
Future<T> showBottomRoundDialog<T>({
  @required BuildContext context,
  @required String title,
  @required List<Widget> children,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).dialogBackgroundColor,
    builder: (context) => _BottomRoundDialog(
      title: title,
      children: children,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

///
class _BottomRoundDialog extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _BottomRoundDialog({
    Key key,
    this.title,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(bottom: 16),
      bottom: false,
      child: RowLayout(
        mainAxisSize: MainAxisSize.min,
        padding: EdgeInsets.only(top: 20),
        space: 16,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: GoogleFonts.rubikTextTheme(
              Theme.of(context).textTheme,
            ).headline6,
            textAlign: TextAlign.center,
          ),
          Flexible(
            child: SingleChildScrollView(
              child: ListBody(
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
