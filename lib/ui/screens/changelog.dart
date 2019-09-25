import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:provider/provider.dart';

import '../../data/models/index.dart';
import '../widgets/index.dart';

/// This screen loads the [CHANGELOG.md] file from GitHub,
/// and displays its content, using the Markdown plugin.
class ChangelogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChangelogModel>(
      builder: (context, model, child) => ReloadablePage<ChangelogModel>(
        title: FlutterI18n.translate(context, 'about.version.changelog'),
        body: Markdown(
          data: model.changelog,
          onTapLink: (url) => FlutterWebBrowser.openWebPage(
            url: url,
            androidToolbarColor: Theme.of(context).primaryColor,
          ),
          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
            blockSpacing: 12,
            h2: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.title.color,
              fontFamily: 'ProductSans',
            ),
            p: TextStyle(
              fontSize: 15,
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
        ),
      ),
    );
  }
}
