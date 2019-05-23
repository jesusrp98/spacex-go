import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

class ChangelogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Changelog"),
        centerTitle: true,
      ),
      body: Markdown(
        data: "WIP",
        onTapLink: (url) async => await FlutterWebBrowser.openWebPage(
              url: url,
              androidToolbarColor: Theme.of(context).primaryColor,
            ),
        styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
            .copyWith(blockSpacing: 12),
      ),
    );
  }
}
