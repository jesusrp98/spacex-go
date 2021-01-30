import 'package:cherry_components/cherry_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info/package_info.dart';
import 'package:row_collection/row_collection.dart';

import '../../util/index.dart';
import '../widgets/index.dart';

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
  PackageInfo _packageInfo = PackageInfo(
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

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
      title: FlutterI18n.translate(context, 'app.menu.about'),
      body: ListView(children: <Widget>[
        HeaderText(
          FlutterI18n.translate(
            context,
            'about.headers.about',
          ),
          head: true,
        ),
        ListCell.icon(
          icon: Icons.info_outline,
          title: FlutterI18n.translate(
            context,
            'about.version.title',
            translationParams: {'version': _packageInfo.version},
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.version.body',
          ),
          onTap: () => Navigator.pushNamed(context, '/changelog'),
        ),
        Separator.divider(indent: 72),
        ListCell.icon(
          icon: Icons.star_border,
          title: FlutterI18n.translate(
            context,
            'about.review.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.review.body',
          ),
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
          title: FlutterI18n.translate(
            context,
            'about.free_software.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.free_software.body',
          ),
          onTap: () => openUrl(Url.appSource),
        ),
        HeaderText(FlutterI18n.translate(
          context,
          'about.headers.author',
        )),
        ListCell.icon(
          icon: Icons.person_outline,
          title: FlutterI18n.translate(
            context,
            'about.author.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.author.body',
          ),
          onTap: () => openUrl(Url.authorProfile),
        ),
        Separator.divider(indent: 72),
        Builder(
          builder: (context) => ListCell.icon(
            icon: Icons.cake,
            title: FlutterI18n.translate(
              context,
              'about.patreon.title',
            ),
            subtitle: FlutterI18n.translate(
              context,
              'about.patreon.body',
            ),
            onTap: () => showPatreonDialog(context),
          ),
        ),
        Separator.divider(indent: 72),
        ListCell.icon(
          icon: Icons.mail_outline,
          title: FlutterI18n.translate(
            context,
            'about.email.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.email.body',
          ),
          onTap: () => openUrl(Url.emailUrl),
        ),
        HeaderText(FlutterI18n.translate(
          context,
          'about.headers.credits',
        )),
        ListCell.icon(
          icon: Icons.translate,
          title: FlutterI18n.translate(
            context,
            'about.translations.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.translations.body',
          ),
          onTap: () => showBottomRoundDialog(
            context: context,
            title: FlutterI18n.translate(
              context,
              'about.translations.title',
            ),
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
          title: FlutterI18n.translate(
            context,
            'about.flutter.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.flutter.body',
          ),
          onTap: () => openUrl(Url.flutterPage),
        ),
        Separator.divider(indent: 72),
        ListCell.icon(
          icon: Icons.folder_open,
          title: FlutterI18n.translate(
            context,
            'about.credits.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.credits.body',
          ),
          onTap: () => openUrl(Url.apiSource),
        ),
        Separator.divider(indent: 72),
      ]),
    );
  }
}
