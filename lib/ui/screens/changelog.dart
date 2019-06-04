import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/changelog.dart';

class ChangelogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ChangelogModel>(
      builder: (context, child, model) => Scaffold(
            appBar: AppBar(
              title: Text(
                FlutterI18n.translate(context, 'about.version.changelog'),
              ),
              centerTitle: true,
            ),
            body: model.isLoading
                ? Center(child: CircularProgressIndicator())
                : Markdown(
                    data: model.changelog,
                    onTapLink: (url) async =>
                        await FlutterWebBrowser.openWebPage(
                          url: url,
                          androidToolbarColor: Theme.of(context).primaryColor,
                        ),
                    styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                        .copyWith(blockSpacing: 12),
                  ),
          ),
    );
  }
}
