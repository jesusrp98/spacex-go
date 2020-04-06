import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../repositories/index.dart';
import '../widgets/index.dart';

/// This screen loads the [CHANGELOG.md] file from GitHub,
/// and displays its content, using the Markdown plugin.
class ChangelogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChangelogRepository>(
      builder: (context, model, child) => ReloadablePage<ChangelogRepository>(
        title: FlutterI18n.translate(context, 'about.version.changelog'),
        body: Markdown(
          data: model.changelog ?? '',
          onTapLink: (url) => FlutterWebBrowser.openWebPage(
            url: url,
            androidToolbarColor: Theme.of(context).primaryColor,
          ),
          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
            blockSpacing: 8,
            h2: GoogleFonts.nunito(
              color: Theme.of(context).textTheme.headline6.color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            p: GoogleFonts.nunito(
              color: Theme.of(context).textTheme.caption.color,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
