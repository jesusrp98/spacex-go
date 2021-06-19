import 'package:cherry_components/cherry_components.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:row_collection/row_collection.dart';

import '../../../utils/index.dart';
import '../../widgets/index.dart';

/// Constant list of all translators
const List<Map<String, String>> _translators = [
  {'name': 'Jesús Rodríguez', 'language': 'English'},
  {'name': 'Jesús Rodríguez', 'language': 'Español'},
  {'name': '/u/OuterSpaceCitizen', 'language': 'Portugues'},
  {'name': 'loopsun', 'language': '简体中文'},
  {'name': 'Charlie Merland', 'language': 'Français'},
  {'name': 'Tommi Avery', 'language': 'Italiano'},
  {'name': 'Fatur Rahman S', 'language': 'Bahasa Indonesia'},
  {'name': 'Patrick Kilter', 'language': 'Deutsch'},
];

/// This view contains a list with useful
/// information about the app & its developer.
class AboutScreen extends StatefulWidget {
  const AboutScreen({Key key}) : super(key: key);

  static const route = '/about';

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  PackageInfo _packageInfo;

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  // Gets information about the app itself
  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() => _packageInfo = info);
  }

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: context.translate('app.menu.about'),
      body: ListView(children: <Widget>[
        HeaderText(
          context.translate('about.headers.about'),
          head: true,
        ),
        ListCell.icon(
          icon: Icons.info_outline,
          title: context.translate(
            'about.version.title',
            parameters: {'version': _packageInfo?.version ?? '1.0'},
          ),
          subtitle: context.translate('about.version.body'),
          onTap: () => Navigator.pushNamed(context, '/changelog'),
        ),
        Separator.divider(indent: 72),
        ListCell.icon(
          icon: Icons.star_border,
          title: context.translate('about.review.title'),
          subtitle: context.translate('about.review.body'),
          onTap: () async {
            final inAppReview = InAppReview.instance;
            if (await inAppReview.isAvailable()) {
              inAppReview.requestReview();
            }
          },
        ),
        Separator.divider(indent: 72),
        ListCell.icon(
          icon: Icons.public,
          title: context.translate('about.free_software.title'),
          subtitle: context.translate('about.free_software.body'),
          onTap: () => context.openUrl(Url.appSource),
        ),
        HeaderText(context.translate('about.headers.author')),
        ListCell.icon(
          icon: Icons.person_outline,
          title: context.translate('about.author.title'),
          subtitle: context.translate('about.author.body'),
          onTap: () => context.openUrl(Url.authorProfile),
        ),
        Separator.divider(indent: 72),
        Builder(
          builder: (context) => ListCell.icon(
            icon: Icons.cake_outlined,
            title: context.translate('about.patreon.title'),
            subtitle: context.translate('about.patreon.body'),
            onTap: () => showPatreonDialog(context),
          ),
        ),
        Separator.divider(indent: 72),
        ListCell.icon(
          icon: Icons.mail_outline,
          title: context.translate('about.email.title'),
          subtitle: context.translate('about.email.body'),
          onTap: () => context.openUrl(Url.emailUrl),
        ),
        HeaderText(context.translate('about.headers.credits')),
        ListCell.icon(
          icon: Icons.translate,
          title: context.translate('about.translations.title'),
          subtitle: context.translate('about.translations.body'),
          onTap: () => showBottomRoundDialog(
            context: context,
            title: context.translate('about.translations.title'),
            padding: EdgeInsets.zero,
            children: [
              for (final translation in _translators)
                ListCell(
                  title: translation['name'],
                  subtitle: translation['language'],
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  dense: true,
                )
            ],
          ),
        ),
        Separator.divider(indent: 72),
        ListCell.icon(
          icon: Icons.code,
          title: context.translate('about.flutter.title'),
          subtitle: context.translate('about.flutter.body'),
          onTap: () => context.openUrl(Url.flutterPage),
        ),
        Separator.divider(indent: 72),
        ListCell.icon(
          icon: Icons.folder_open,
          title: context.translate('about.credits.title'),
          subtitle: context.translate('about.credits.body'),
          onTap: () => context.openUrl(Url.apiSource),
        ),
        Separator.divider(indent: 72),
      ]),
    );
  }
}
