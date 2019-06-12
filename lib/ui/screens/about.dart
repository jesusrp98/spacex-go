import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:package_info/package_info.dart';
import 'package:row_collection/row_collection.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/changelog.dart';
import '../../util/url.dart';
import '../../widgets/dialog_round.dart';
import '../../widgets/header_text.dart';
import '../../widgets/list_cell.dart';
import 'changelog.dart';

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
    {'name': 'Jesús Rodríguez', 'language': 'English'},
    {'name': 'Jesús Rodríguez', 'language': 'Español'},
    {'name': '/u/OuterSpaceCitizen\nMatias de Andrea', 'language': 'Portugues'},
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
                  builder: (context) => ScopedModel<ChangelogModel>(
                        model: ChangelogModel()..loadData(),
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
          onTap: () async => await FlutterWebBrowser.openWebPage(
                url: Url.appStore,
                androidToolbarColor: Theme.of(context).primaryColor,
              ),
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
          onTap: () async => await FlutterWebBrowser.openWebPage(
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
          onTap: () async => await FlutterWebBrowser.openWebPage(
                url: Url.authorStore,
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
          onTap: () async => await FlutterWebBrowser.openWebPage(
                url: Url.authorPatreon,
                androidToolbarColor: Theme.of(context).primaryColor,
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
          onTap: () async => await FlutterMailer.send(MailOptions(
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
                                contentPadding: EdgeInsets.symmetric(
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
          onTap: () async => await FlutterWebBrowser.openWebPage(
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
          onTap: () async => await FlutterWebBrowser.openWebPage(
                url: Url.apiSource,
                androidToolbarColor: Theme.of(context).primaryColor,
              ),
        ),
        Separator.divider(indent: 72),
      ]),
    );
  }
}
