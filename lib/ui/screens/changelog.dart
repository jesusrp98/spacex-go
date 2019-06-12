import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/changelog.dart';

/// CHANGELOG SCREEN
/// This screen loads the [CHANGELOG.md] file from GitHub,
/// and displays its content, using the Markdown plugin.
class ChangelogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO fix loading when no connection
    return ScopedModelDescendant<ChangelogModel>(
      builder: (context, child, model) => Scaffold(
            appBar: AppBar(
              title: Text(
                FlutterI18n.translate(context, 'about.version.changelog'),
              ),
              centerTitle: true,
            ),
            body: model.isLoading || model.items.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Markdown(
                    data: model.changelog,
                    onTapLink: (url) async =>
                        await FlutterWebBrowser.openWebPage(
                          url: url,
                          androidToolbarColor: Theme.of(context).primaryColor,
                        ),
                    styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                        .copyWith(
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
                        fontFamily: 'ProductSans',
                      ),
                    ),
                  ),
          ),
    );
  }
}
