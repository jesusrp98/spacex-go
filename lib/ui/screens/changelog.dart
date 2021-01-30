import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../cubits/changelog.dart';
import '../../util/index.dart';
import '../widgets/index.dart';

/// This screen loads the [CHANGELOG.md] file from GitHub,
/// and displays its content, using the Markdown plugin.
class ChangelogScreen extends StatelessWidget {
  static const route = '/changelog';

  @override
  Widget build(BuildContext context) {
    return RequestSimplePage<ChangelogCubit, String>(
      title: FlutterI18n.translate(context, 'about.version.changelog'),
      childBuilder: (context, state, value) => Markdown(
        data: value,
        onTapLink: (_, url, __) => openUrl(url),
        styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
          blockSpacing: 10,
          h2: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme)
              .subtitle1
              .copyWith(
                fontWeight: FontWeight.bold,
              ),
          p: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme)
              .bodyText2
              .copyWith(
                color: Theme.of(context).textTheme.caption.color,
              ),
        ),
      ),
    );
  }
}
