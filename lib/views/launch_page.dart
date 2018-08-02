import 'package:cherry/classes/core.dart';
import 'package:cherry/classes/launch.dart';
import 'package:cherry/classes/payload.dart';
import 'package:cherry/classes/rocket.dart';
import 'package:cherry/colors.dart';
import 'package:cherry/widgets/card_page.dart';
import 'package:cherry/widgets/head_card_page.dart';
import 'package:cherry/widgets/row_item.dart';
import 'package:cherry/classes/second_stage.dart';
import 'package:cherry/widgets/details_dialog.dart';
import 'package:cherry/widgets/hero_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

class LaunchPage extends StatelessWidget {
  final Launch launch;
  static List<String> popupItems = [
    'Reddit campaing...',
    'YouTube video...',
    'Press kit...'
  ];

  LaunchPage(this.launch);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Launch details'),
          actions: <Widget>[
            PopupMenuButton<String>(
              itemBuilder: (context) {
                return popupItems.map((f) {
                  return PopupMenuItem(
                    value: f,
                    child: Text(f),
                  );
                }).toList();
              },
              onSelected: (String option) => openWeb(context, option),
            )
          ],
        ),
        body: Scrollbar(
            child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  _MissionCard(launch),
                  SizedBox(
                    height: 8.0,
                  ),
                  _FirstStageCard(launch.rocket),
                  SizedBox(
                    height: 8.0,
                  ),
                  _SecondStageCard(launch.rocket.secondStage),
                  SizedBox(
                    height: 8.0,
                  ),
                  _ReusingCard(launch),
                ],
              ),
            )
          ],
        )));
  }

  openWeb(BuildContext context, String option) async {
    String url;

    if (option == popupItems[0])
      url = launch.linkReddit;
    else if (option == popupItems[1])
      url = launch.linkYouTube;
    else
      url = launch.linkPress;

    if (url == null)
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Unavailable link'),
                content: Text(
                    'The link has not been yet provided. Please try again later...'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ));
    else
      await FlutterWebBrowser.openWebPage(url: url);
  }
}

class _MissionCard extends StatelessWidget {
  final Launch launch;

  _MissionCard(this.launch);

  @override
  Widget build(BuildContext context) {
    return HeadCardPage(
      head: Row(
        children: <Widget>[
          HeroImage().buildHero(
              context: context,
              size: 116.0,
              url: launch.getImageUrl,
              tag: launch.getMissionNumber,
              title: launch.missionName),
          Container(width: 24.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(launch.missionName,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline
                        .copyWith(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  launch.getDate,
                  style: Theme
                      .of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: secondaryText),
                ),
                SizedBox(
                  height: 12.0,
                ),
                InkWell(
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) => DetailsDialog.launchpad(
                          launch.missionLaunchSiteId,
                          launch.missionLaunchSite)),
                  child: Text(launch.missionLaunchSite,
                      style: Theme.of(context).textTheme.subhead.copyWith(
                          decoration: TextDecoration.underline,
                          color: secondaryText)),
                ),
              ],
            ),
          )
        ],
      ),
      details: launch.getDetails,
    );
  }
}

class _FirstStageCard extends StatelessWidget {
  final Rocket rocket;

  _FirstStageCard(this.rocket);

  @override
  Widget build(BuildContext context) {
    return CardPage(
      title: 'ROCKET',
      body: <Widget>[
        RowItem.textRow('Rocket name', rocket.name),
        SizedBox(
          height: 12.0,
        ),
        RowItem.textRow('Rocket type', rocket.type),
        Column(
          children:
              rocket.firstStage.map((m) => _getCores(context, m)).toList(),
        )
      ],
    );
  }

  Widget _getCores(BuildContext context, Core core) {
    return Column(
      children: <Widget>[
        Divider(
          height: 24.0,
        ),
        RowItem.textRow('Core block', core.getBlock),
        SizedBox(
          height: 12.0,
        ),
        RowItem.dialogRow(context, 'Core serial', core.getId,
            DetailsDialog.core(core.getId, 'Core ${core.getId}')),
        SizedBox(
          height: 12.0,
        ),
        RowItem.textRow('Total flights', core.getFlights),
        SizedBox(
          height: 12.0,
        ),
        (core.getLandingZone != 'Unknown')
            ? Column(
                children: <Widget>[
                  RowItem.textRow('Landing zone', core.getLandingZone),
                  SizedBox(
                    height: 12.0,
                  ),
                  RowItem.iconRow('Landing success', core.isLandingSuccess)
                ],
              )
            : RowItem.iconRow('Landing attempt', core.getLandingZone == null),
      ],
    );
  }
}

class _SecondStageCard extends StatelessWidget {
  final SecondStage secondStage;

  _SecondStageCard(this.secondStage);

  @override
  Widget build(BuildContext context) {
    return CardPage(
      title: 'PAYLOAD',
      body: <Widget>[
        RowItem.textRow('Second stage block', secondStage.getBlock),
        SizedBox(
          height: 12.0,
        ),
        RowItem.textRow(
            'Total payload', secondStage.getNumberPayload.toString()),
        Column(
          children:
              secondStage.payloads.map((m) => _getPayload(context, m)).toList(),
        )
      ],
    );
  }

  Widget _getPayload(BuildContext context, Payload payload) {
    return Column(
      children: <Widget>[
        Divider(
          height: 24.0,
        ),
        RowItem.textRow('Payload name', payload.getId),
        SizedBox(
          height: 12.0,
        ),
        RowItem.textRow('Payload type', payload.getPayloadType),
        (payload.getCustomer == 'NASA (CRS)')
            ? Column(
                children: <Widget>[
                  SizedBox(
                    height: 12.0,
                  ),
                  RowItem.dialogRow(
                      context,
                      'Dragon serial',
                      payload.getDragonSerial,
                      DetailsDialog.dragon(payload.dragonSerial,
                          'Capsule ${payload.dragonSerial}')),
                  SizedBox(
                    height: 12.0,
                  )
                ],
              )
            : SizedBox(height: 12.0),
        RowItem.textRow('Customer', payload.getCustomer),
        SizedBox(
          height: 12.0,
        ),
        RowItem.textRow('Mass', payload.getMass),
        SizedBox(
          height: 12.0,
        ),
        RowItem.textRow('Orbit', payload.getOrbit),
      ],
    );
  }
}

class _ReusingCard extends StatelessWidget {
  final Launch launch;

  _ReusingCard(this.launch);

  @override
  Widget build(BuildContext context) {
    return CardPage(
      title: 'REUSED PARTS',
      body: <Widget>[
        RowItem.iconRow('Central booster', launch.rocket.isCoreReused),
        SizedBox(
          height: 12.0,
        ),
        RowItem.iconRow('Left booster',
            launch.rocket.isHeavy ? launch.rocket.isLeftBoosterReused : null),
        SizedBox(
          height: 12.0,
        ),
        RowItem.iconRow('Right booster',
            launch.rocket.isHeavy ? launch.rocket.isRightBoosterReused : null),
        SizedBox(
          height: 12.0,
        ),
        RowItem.iconRow('Dragon capsule', launch.capsuleReused),
        SizedBox(
          height: 12.0,
        ),
        RowItem.iconRow('Fairings', launch.fairingReused),
      ],
    );
  }
}
