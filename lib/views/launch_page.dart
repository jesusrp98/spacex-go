import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../classes/core.dart';
import '../classes/fairing.dart';
import '../classes/launch.dart';
import '../classes/rocket.dart';
import '../classes/second_stage.dart';
import '../colors.dart';
import '../widgets/card_page.dart';
import '../widgets/details_dialog.dart';
import '../widgets/head_card_page.dart';
import '../widgets/hero_image.dart';
import '../widgets/row_item.dart';

/// LAUNCH PAGE CLASS
/// This class displays all information of a specific launch.
class LaunchPage extends StatelessWidget {
  final Launch _launch;
  static const List<String> _popupItems = [
    'Reddit campaign',
    'YouTube video',
    'Press kit',
    'Article',
  ];

  LaunchPage(this._launch);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Launch details'),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<String>(
            itemBuilder: (context) {
              return _popupItems.map((f) {
                return PopupMenuItem(value: f, child: Text(f));
              }).toList();
            },
            onSelected: (String option) => openWeb(context, option),
          ),
        ],
      ),
      body: Scrollbar(
        child: ListView(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(children: <Widget>[
              _missionCard(context),
              const SizedBox(height: 8.0),
              _firstStageCard(context),
              const SizedBox(height: 8.0),
              _secondStageCard(context),
            ]),
          )
        ]),
      ),
    );
  }

  /// Method used for opening webs from the popup menu
  openWeb(BuildContext context, String option) async {
    final String url = _launch.links[_popupItems.indexOf(option)];

    if (url == null)
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Unavailable link'),
              content: Text(
                'Link has not been yet provided by the service. Please try again at a later time.',
              ),
              actions: <Widget>[
                FlatButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(context).pop()),
              ],
            ),
      );
    else
      await FlutterWebBrowser.openWebPage(
        url: url,
        androidToolbarColor: primaryColor,
      );
  }

  Widget _missionCard(BuildContext context) {
    return HeadCardPage(
      image: HeroImage().buildExpandedHero(
        context: context,
        size: HeroImage.bigSize,
        url: _launch.getImageUrl,
        tag: _launch.getNumber,
        title: _launch.name,
      ),
      title: _launch.name,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _launch.getLaunchDate,
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: secondaryText),
          ),
          const SizedBox(height: 12.0),
          InkWell(
            onTap: () => showDialog(
                  context: context,
                  builder: (context) => DetailsDialog.launchpad(
                        id: _launch.launchpadId,
                        title: _launch.launchpadName,
                      ),
                ),
            child: Text(
              _launch.launchpadName,
              style: Theme.of(context).textTheme.subhead.copyWith(
                    decoration: TextDecoration.underline,
                    color: secondaryText,
                  ),
            ),
          ),
        ],
      ),
      details: _launch.getDetails,
    );
  }

  Widget _firstStageCard(BuildContext context) {
    final Rocket rocket = _launch.rocket;

    return CardPage(
      title: 'ROCKET',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow('Rocket name', rocket.name),
          const SizedBox(height: 12.0),
          RowItem.textRow('Model', rocket.type),
          const SizedBox(height: 12.0),
          RowItem.textRow('Static fire date', _launch.getStaticFireDate),
          const SizedBox(height: 12.0),
          RowItem.iconRow('Launch success', _launch.launchSuccess),
          Column(
            children: rocket.firstStage
                .map((core) => _getCores(context, core))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _secondStageCard(BuildContext context) {
    final SecondStage secondStage = _launch.rocket.secondStage;
    final Fairing fairing = _launch.rocket.fairing;

    return CardPage(
      title: 'PAYLOAD',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow('Second stage model', secondStage.getBlock),
          (_launch.rocket.hasFairing)
              ? Column(
                  children: <Widget>[
                    const Divider(height: 24.0),
                    RowItem.iconRow('Fairings reused', fairing.reused),
                    const SizedBox(height: 12.0),
                    (fairing.recoveryAttempt == true)
                        ? Column(
                            children: <Widget>[
                              RowItem.iconRow(
                                  'Recovery success', fairing.recoverySuccess),
                              const SizedBox(height: 12.0),
                              RowItem.textRow('Recovery ship', fairing.ship),
                            ],
                          )
                        : RowItem.iconRow(
                            'Recovery attempt', fairing.recoveryAttempt),
                  ],
                )
              : const SizedBox(height: 0.0),
          Column(
            children: secondStage.payloads
                .map((payload) => _getPayload(context, payload))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _getCores(BuildContext context, Core core) {
    return Column(children: <Widget>[
      const Divider(height: 24.0),
      RowItem.dialogRow(
        context,
        'Core serial',
        core.getId,
        DetailsDialog.core(id: core.getId, title: 'Core ${core.getId}'),
      ),
      const SizedBox(height: 12.0),
      RowItem.textRow('Model', core.getBlock),
      const SizedBox(height: 12.0),
      RowItem.iconRow('Reused', core.reused),
      const SizedBox(height: 12.0),
      (core.getLandingZone != 'Unknown')
          ? Column(children: <Widget>[
              RowItem.textRow('Landing type', core.getLandingType),
              const SizedBox(height: 12.0),
              RowItem.textRow('Landing zone', core.getLandingZone),
              const SizedBox(height: 12.0),
              RowItem.iconRow('Landing success', core.landingSuccess)
            ])
          : RowItem.iconRow('Landing attempt', core.landingIntent),
    ]);
  }

  Widget _getPayload(BuildContext context, Payload payload) {
    return Column(children: <Widget>[
      const Divider(height: 24.0),
      RowItem.textRow('Payload name', payload.getId),
      (payload.isNasaPayload)
          ? Column(children: <Widget>[
              const SizedBox(height: 12.0),
              RowItem.dialogRow(
                context,
                'Capsule serial',
                payload.getCapsuleSerial,
                DetailsDialog.capsule(
                  id: payload.getCapsuleSerial,
                  title: 'Capsule ${payload.getCapsuleSerial}',
                ),
              ),
              const SizedBox(height: 12.0),
              RowItem.iconRow('Reused', payload.reused),
              const SizedBox(height: 12.0)
            ])
          : const SizedBox(height: 12.0),
      RowItem.textRow('Manufacturer', payload.getManufacturer),
      const SizedBox(height: 12.0),
      RowItem.textRow('Customer', payload.getCustomer),
      const SizedBox(height: 12.0),
      RowItem.textRow('Nationality', payload.getNationality),
      const SizedBox(height: 12.0),
      RowItem.textRow('Mass', payload.getMass),
      const SizedBox(height: 12.0),
      RowItem.textRow('Orbit', payload.getOrbit),
    ]);
  }
}
