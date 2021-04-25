import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../cubits/changelog.dart';
import '../../../utils/index.dart';
import '../../widgets/index.dart';

/// This screen loads the [CHANGELOG.md] file from GitHub,
/// and displays its content, using the Markdown plugin.
class ChangelogScreen extends StatelessWidget {
  static const route = '/changelog';

  @override
  Widget build(BuildContext context) {
    return RequestSimplePage<ChangelogCubit, String>(
      title: context.translate('about.version.changelog'),
      childBuilder: (context, state, value) => Markdown(
        data: value,
        onTapLink: (_, url, __) => context.openUrl(url),
        styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
          blockSpacing: 10,
          h2: Theme.of(context).textTheme.subtitle1.copyWith(
                fontWeight: FontWeight.bold,
              ),
          p: Theme.of(context).textTheme.bodyText2.copyWith(
                color: Theme.of(context).textTheme.caption.color,
              ),
        ),
      ),
    );
  }
}
