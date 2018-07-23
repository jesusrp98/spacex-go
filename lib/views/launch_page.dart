import 'package:cherry/views/hero_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../classes/launch.dart';
import '../classes/rocket.dart';
import '../classes/core.dart';
import '../classes/second_stage.dart';
import '../classes/payload.dart';
import '../classes/row_item.dart';
import 'details_dialog.dart';

class LaunchPage extends StatelessWidget {
  final Launch launch;
  static final List<String> popupItems = [
    'Reddit campaing...',
    'YouTube video...',
    'Article...'
  ];

  LaunchPage(this.launch);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Launch details'),
          actions: <Widget>[
            PopupMenuButton(
              itemBuilder: (context) {
                return popupItems.map((f) {
                  return PopupMenuItem(
                    value: f,
                    child: Text(f),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  _MissionCard(launch),
                  SizedBox(
                    height: 16.0,
                  ),
                  _FirstStageCard(launch.rocket),
                  SizedBox(
                    height: 16.0,
                  ),
                  _SecondStageCard(launch.rocket.secondStage),
                  SizedBox(
                    height: 16.0,
                  ),
                  _ReusingCard(launch),
                ],
              ),
            )
          ],
        ));
  }
}

class _MissionCard extends StatelessWidget {
  final Launch launch;

  _MissionCard(this.launch);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  HeroImage(
                    size: 128.0,
                    url: launch.getImageUrl,
                    tag: launch.getMissionNumber
                  ),
                  Container(width: 24.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          launch.missionName,
                          style: TextStyle(
                              fontSize: 26.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          launch.getDate,
                          style: TextStyle(fontSize: 17.0),
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
                              style: TextStyle(
                                  fontSize: 17.0,
                                  decoration: TextDecoration.underline)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Divider(
                height: 24.0,
              ),
              Text(
                launch.getDetails,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15.0),
              ),
            ],
          )),
    );
  }
}

class _FirstStageCard extends StatelessWidget {
  final Rocket rocket;

  _FirstStageCard(this.rocket);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'ROCKET',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.0),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RowItem.textRow('Rocket name', rocket.name),
                  SizedBox(
                    height: 12.0,
                  ),
                  RowItem.textRow('Rocket type', rocket.type),
                  Column(
                    children: rocket.firstStage
                        .map((m) => _getCores(context, m))
                        .toList(),
                  )
                  //_refurbishItem('Fairings', launch.fairingReused),
                ],
              ),
            ],
          ),
        ));
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
    return Card(
        elevation: 6.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'PAYLOAD',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.0),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RowItem.textRow('Second stage block', secondStage.getBlock),
                  SizedBox(
                    height: 12.0,
                  ),
                  RowItem.textRow(
                      'Total payload', secondStage.getNumberPayload.toString()),
                  Column(
                    children: secondStage.payloads
                        .map((m) => _getPayload(context, m))
                        .toList(),
                  )
                  //_refurbishItem('Fairings', launch.fairingReused),
                ],
              ),
            ],
          ),
        ));
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
    return Card(
        elevation: 6.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'REUSED PARTS',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.0),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RowItem.iconRow(
                      'Central booster', launch.rocket.isCoreReused),
                  SizedBox(
                    height: 12.0,
                  ),
                  RowItem.iconRow(
                      'Left booster',
                      launch.rocket.isHeavy
                          ? launch.rocket.isLeftBoosterReused
                          : null),
                  SizedBox(
                    height: 12.0,
                  ),
                  RowItem.iconRow(
                      'Right booster',
                      launch.rocket.isHeavy
                          ? launch.rocket.isRightBoosterReused
                          : null),
                  SizedBox(
                    height: 12.0,
                  ),
                  RowItem.iconRow('Dragon capsule', launch.capsuleReused),
                  SizedBox(
                    height: 12.0,
                  ),
                  RowItem.iconRow('Fairings', launch.fairingReused),
                ],
              ),
            ],
          ),
        ));
  }
}
