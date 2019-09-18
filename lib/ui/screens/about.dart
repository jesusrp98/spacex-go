import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:launch_review/launch_review.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';

import '../../data/models/index.dart';
import '../../util/url.dart';
import '../widgets/index.dart';
import 'index.dart';

/// Constant list of all translators
const List<Map<String, String>> _translators = [
  {'name': 'Jesús Rodríguez', 'language': 'English'},
  {'name': 'Jesús Rodríguez', 'language': 'Español'},
  {'name': '/u/OuterSpaceCitizen', 'language': 'Portugues'},
];

/// This view contains a list with useful
/// information about the app & its developer.
class AboutScreen extends StatefulWidget {
  const AboutScreen({Key key}) : super(key: key);

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
    return BlanckPage(
      title: FlutterI18n.translate(context, 'app.menu.about'),
      body: ListView(children: <Widget>[
        HeaderText(FlutterI18n.translate(
          context,
          'about.headers.about',
        )),
        ListCell.icon(
          icon: Icons.info_outline,
          trailing: Icon(Icons.chevron_right),
          title: FlutterI18n.translate(
            context,
            'about.version.title',
            {'version': _packageInfo.version},
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.version.body',
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider<ChangelogModel>(
                builder: (context) => ChangelogModel(),
                child: ChangelogScreen(),
              ),
              fullscreenDialog: true,
            ),
          ),
        ),
        Separator.divider(indent: 72),
        ListCell.icon(
          icon: Icons.star_border,
          trailing: Icon(Icons.chevron_right),
          title: FlutterI18n.translate(
            context,
            'about.review.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.review.body',
          ),
          onTap: () => LaunchReview.launch(),
        ),
        Separator.divider(indent: 72),
        ListCell.icon(
          icon: Icons.public,
          trailing: Icon(Icons.chevron_right),
          title: FlutterI18n.translate(
            context,
            'about.free_software.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.free_software.body',
          ),
          onTap: () => FlutterWebBrowser.openWebPage(
            url: Url.appSource,
            androidToolbarColor: Theme.of(context).primaryColor,
          ),
        ),
        HeaderText(FlutterI18n.translate(
          context,
          'about.headers.author',
        )),
        ListCell.icon(
          icon: Icons.person_outline,
          trailing: Icon(Icons.chevron_right),
          title: FlutterI18n.translate(
            context,
            'about.author.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.author.body',
          ),
          onTap: () => FlutterWebBrowser.openWebPage(
            url: Url.authorProfile,
            androidToolbarColor: Theme.of(context).primaryColor,
          ),
        ),
        Separator.divider(indent: 72),
        ListCell.icon(
          icon: Icons.cake,
          trailing: Icon(Icons.chevron_right),
          title: FlutterI18n.translate(
            context,
            'about.patreon.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.patreon.body',
          ),
          onTap: () => showDialog(
            context: context,
            builder: (context) => PatreonDialog.about(context),
          ),
        ),
        Separator.divider(indent: 72),
        ListCell.icon(
          icon: Icons.mail_outline,
          trailing: Icon(Icons.chevron_right),
          title: FlutterI18n.translate(
            context,
            'about.email.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.email.body',
          ),
          onTap: () => FlutterMailer.send(MailOptions(
            subject: Url.authorEmail['subject'],
            recipients: [Url.authorEmail['address']],
          )),
        ),
        HeaderText(FlutterI18n.translate(
          context,
          'about.headers.credits',
        )),
        ListCell.icon(
          icon: Icons.translate,
          trailing: Icon(Icons.chevron_right),
          title: FlutterI18n.translate(
            context,
            'about.translations.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.translations.body',
          ),
          onTap: () => showDialog(
            context: context,
            builder: (context) => RoundDialog(
              title: FlutterI18n.translate(
                context,
                'about.translations.title',
              ),
              children: _translators
                  .map((translation) => ListCell(
                        title: translation['name'],
                        subtitle: translation['language'],
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 24,
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        Separator.divider(indent: 72),
        ListCell.icon(
          icon: Icons.code,
          trailing: Icon(Icons.chevron_right),
          title: FlutterI18n.translate(
            context,
            'about.flutter.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.flutter.body',
          ),
          onTap: () => FlutterWebBrowser.openWebPage(
            url: Url.flutterPage,
            androidToolbarColor: Theme.of(context).primaryColor,
          ),
        ),
        Separator.divider(indent: 72),
        ListCell.icon(
          icon: Icons.folder_open,
          trailing: Icon(Icons.chevron_right),
          title: FlutterI18n.translate(
            context,
            'about.credits.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.credits.body',
          ),
          onTap: () => FlutterWebBrowser.openWebPage(
            url: Url.apiSource,
            androidToolbarColor: Theme.of(context).primaryColor,
          ),
        ),
        Separator.divider(indent: 72),
      ]),
    );
  }
}
