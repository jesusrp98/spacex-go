import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import '../classes/launch.dart';
import '../classes/rocket.dart';
import '../classes/core.dart';
import '../classes/rocket_info.dart';
import '../classes/second_stage.dart';
import '../classes/payload.dart';
import 'dialog_detail.dart';
import 'rocket_page.dart';

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
                  launch.getHeroImage(128.0),
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
                              builder: (context) => DialogDetail(
                                  type: 0,
                                  id: launch.missionLaunchSiteId,
                                  title: launch.missionLaunchSite)),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 24.0, bottom: 18.0),
            child: Text(
              'ROCKET',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.0),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                rowClickableItem(context, 'Rocket name', rocket.name, null,
                    serial: rocket.id),
                SizedBox(
                  height: 6.0,
                ),
                rowItem('Rocket type', rocket.type),
                Column(
                  children: rocket.firstStage
                      .map((m) => _getCores(context, m))
                      .toList(),
                )
                //_refurbishItem('Fairings', launch.fairingReused),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getCores(BuildContext context, Core core) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Divider(
            height: 24.0,
          ),
        ),
        rowItem('Core block', core.getBlock),
        SizedBox(
          height: 6.0,
        ),
        rowClickableItem(context, 'Core serial', core.getId,
            DialogDetail(type: 1, id: core.getId, title: 'Core ' + core.getId)),
        SizedBox(
          height: 6.0,
        ),
        rowItem('Total flights', core.getFlights),
        SizedBox(
          height: 12.0,
        ),
        (core.getLandingZone != 'Unknown')
            ? Column(
                children: <Widget>[
                  rowItem('Landing zone', core.getLandingZone),
                  SizedBox(
                    height: 12.0,
                  ),
                  rowIconItem('Landing success', core.isLandingSuccess)
                ],
              )
            : rowIconItem('Landing attempt', core.getLandingZone == null),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(24.0),
            child: Text(
              'PAYLOAD',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.0),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                rowItem('Second stage block', secondStage.getBlock),
                SizedBox(
                  height: 12.0,
                ),
                rowItem(
                    'Total payload', secondStage.getNumberPayload.toString()),
                Column(
                  children: secondStage.payloads
                      .map((m) => _getPayload(context, m))
                      .toList(),
                )
                //_refurbishItem('Fairings', launch.fairingReused),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getPayload(BuildContext context, Payload payload) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Divider(
            height: 24.0,
          ),
        ),
        rowItem('Payload name', payload.getId),
        SizedBox(
          height: 12.0,
        ),
        rowItem('Payload type', payload.getPayloadType),
        (payload.getCustomer == 'NASA (CRS)')
            ? Column(
                children: <Widget>[
                  SizedBox(
                    height: 6.0,
                  ),
                  rowClickableItem(
                      context,
                      'Dragon serial',
                      payload.getDragonSerial,
                      DialogDetail(
                          type: 2,
                          id: payload.dragonSerial,
                          title: payload.dragonSerial)),
                  SizedBox(
                    height: 6.0,
                  )
                ],
              )
            : SizedBox(height: 12.0),
        rowItem('Customer', payload.getCustomer),
        SizedBox(
          height: 12.0,
        ),
        rowItem('Mass', payload.getMass),
        SizedBox(
          height: 12.0,
        ),
        rowItem('Orbit', payload.getOrbit),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(24.0),
            child: Text(
              'REUSED PARTS',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.0),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                rowIconItem('Central booster', launch.rocket.isCoreReused),
                SizedBox(
                  height: 12.0,
                ),
                rowIconItem(
                    'Left booster',
                    launch.rocket.isHeavy
                        ? launch.rocket.isLeftBoosterReused
                        : null),
                SizedBox(
                  height: 12.0,
                ),
                rowIconItem(
                    'Right booster',
                    launch.rocket.isHeavy
                        ? launch.rocket.isRightBoosterReused
                        : null),
                SizedBox(
                  height: 12.0,
                ),
                rowIconItem('Dragon capsule', launch.capsuleReused),
                SizedBox(
                  height: 12.0,
                ),
                rowIconItem('Fairings', launch.fairingReused),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget rowItem(String name, String description, [bool isClickable = false]) {
  return Container(
    margin: EdgeInsets.only(left: 24.0, right: 24.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          name,
          style: TextStyle(fontSize: 17.0),
        ),
        Text(
          description,
          style: TextStyle(
              fontSize: 17.0,
              color: Colors.white70,
              decoration:
                  isClickable ? TextDecoration.underline : TextDecoration.none),
        ),
      ],
    ),
  );
}

Widget rowIconItem(String name, bool icon) {
  return Container(
    margin: EdgeInsets.only(left: 24.0, right: 24.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          name,
          style: TextStyle(fontSize: 17.0),
        ),
        rowIcon(icon)
      ],
    ),
  );
}

Widget rowClickableItem(
    BuildContext context, String name, String description, DialogDetail dialog,
    {String serial = ''}) {
  return FlatButton(
    padding: EdgeInsets.all(0.0),
    onPressed: () async {
      if (description != 'Unknown') if (dialog != null)
        showDialog(context: context, builder: (context) => dialog);
      else {
        var rocketInfo = await _getRocketInfo(serial);
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => RocketPage(rocketInfo)));
      }
      else
        Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Error fetching data'),
            ));
    },
    child: rowItem(name, description, true),
  );
}

Widget rowIcon(bool state) {
  return Icon(
    state == null
        ? Icons.remove_circle
        : (state ? Icons.check_circle : Icons.cancel),
    color:
        state == null ? Colors.blueGrey : (state ? Colors.green : Colors.red),
  );
}

Future<RocketInfo> _getRocketInfo(String serial) async {
  final response =
      await http.get('https://api.spacexdata.com/v2/rockets/' + serial);

  return RocketInfo.fromJson(json.decode(response.body));
}
