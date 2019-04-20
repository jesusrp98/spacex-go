import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:package_info/package_info.dart';

import '../../util/url.dart';
import '../../widgets/dialog_round.dart';
import '../../widgets/header_text.dart';
import '../../widgets/list_cell.dart';
import '../../widgets/separator.dart';

/// ABOUT SCREEN
/// This view contains a list with useful
/// information about the app & its developer.
class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  // Static list of all translators
  static final List<Map<String, String>> _translators = [
    {'name': 'Max Coremans', 'language': 'Nederlands'},
    {'name': 'Jesús Rodríguez', 'language': 'English'},
    {'name': '/u/OuterSpaceCitizen', 'language': 'Portugues'},
    {'name': 'Jesús Rodríguez', 'language': 'Español'},
  ];

  PackageInfo _packageInfo = PackageInfo(
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  initState() {
    super.initState();
    _initPackageInfo();
  }

  // Gets information about the app itself
  Future<Null> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() => _packageInfo = info);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(
          context,
          'app.menu.about',
        )),
        centerTitle: true,
      ),
      body: ListView(children: <Widget>[
        HeaderText(FlutterI18n.translate(
          context,
          'about.headers.about',
        )),
        ListCell(
          leading: const Icon(Icons.info_outline, size: 40),
          title: FlutterI18n.translate(
            context,
            'about.version.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.version.body',
            {'version': _packageInfo.version, 'status': 'release'},
          ),
        ),
        Separator.divider(height: 0, indent: 72),
        ListCell(
          leading: const Icon(Icons.star_border, size: 40),
          title: FlutterI18n.translate(
            context,
            'about.review.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.review.body',
          ),
          onTap: () async => await FlutterWebBrowser.openWebPage(
                url: Url.appStore,
                androidToolbarColor: Theme.of(context).primaryColor,
              ),
        ),
        Separator.divider(height: 0, indent: 72),
        ListCell(
          leading: const Icon(Icons.people_outline, size: 40),
          title: FlutterI18n.translate(
            context,
            'about.free_software.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.free_software.body',
          ),
          onTap: () async => await FlutterWebBrowser.openWebPage(
                url: Url.appSource,
                androidToolbarColor: Theme.of(context).primaryColor,
              ),
        ),
        HeaderText(FlutterI18n.translate(
          context,
          'about.headers.author',
        )),
        ListCell(
          leading: const Icon(Icons.person_outline, size: 40),
          title: FlutterI18n.translate(
            context,
            'about.author.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.author.body',
          ),
          onTap: () async => await FlutterWebBrowser.openWebPage(
                url: Url.authorStore,
                androidToolbarColor: Theme.of(context).primaryColor,
              ),
        ),
        Separator.divider(height: 0, indent: 72),
        ListCell(
          leading: const Icon(Icons.cake, size: 40),
          title: FlutterI18n.translate(
            context,
            'about.patreon.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.patreon.body',
          ),
          onTap: () async => await FlutterWebBrowser.openWebPage(
                url: Url.authorPatreon,
                androidToolbarColor: Theme.of(context).primaryColor,
              ),
        ),
        Separator.divider(height: 0, indent: 72),
        ListCell(
          leading: const Icon(Icons.mail_outline, size: 40),
          title: FlutterI18n.translate(
            context,
            'about.email.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.email.body',
          ),
          onTap: () async => await FlutterMailer.send(MailOptions(
                subject: Url.authorEmail['subject'],
                recipients: [Url.authorEmail['address']],
              )),
        ),
        HeaderText(FlutterI18n.translate(
          context,
          'about.headers.credits',
        )),
        ListCell(
          leading: const Icon(Icons.translate, size: 40),
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
        Separator.divider(height: 0, indent: 72),
        ListCell(
          leading: const Icon(Icons.code, size: 40),
          title: FlutterI18n.translate(
            context,
            'about.flutter.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.flutter.body',
          ),
          onTap: () async => await FlutterWebBrowser.openWebPage(
                url: Url.flutterPage,
                androidToolbarColor: Theme.of(context).primaryColor,
              ),
        ),
        Separator.divider(height: 0, indent: 72),
        ListCell(
          leading: const Icon(Icons.folder_open, size: 40),
          title: FlutterI18n.translate(
            context,
            'about.credits.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.credits.body',
          ),
          onTap: () async => await FlutterWebBrowser.openWebPage(
                url: Url.apiSource,
                androidToolbarColor: Theme.of(context).primaryColor,
              ),
        ),
        Separator.divider(height: 0, indent: 72),
      ]),
    );
  }
}
