import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'dart:async';

import '../classes/launch.dart';
import '../classes/rocket.dart';
import '../classes/core.dart';
import '../classes/second_stage.dart';
import '../classes/payload.dart';

class LaunchPage extends StatelessWidget {
  final Launch launch;
  final List<String> popupItems = [
    'Reddit campaing...',
    'YouTube video...',
    'Article...'
  ];

  LaunchPage(this.launch);

  /*_selectedUrl() async {
    const url = 'https://flutter.io';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Launch details'),
          actions: <Widget>[
            PopupMenuButton(
              //onSelected: _selectedUrl,
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
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _MissionCard(context, launch),
                  _FirstStageCard(context, launch.getRocket()),
                  _SecondStageCard(
                      context, launch.getRocket().getSecondStage()),
                  _ReusingCard(launch),
                ],
              ),
            )
          ],
        ));
  }
}

class _MissionCard extends StatelessWidget {
  final Launch _launch;
  final BuildContext context;

  _MissionCard(this.context, this._launch);

  Widget _getLaunchPadDialog() {
    return Text('launch');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _launch.getHeroImage(128.0),
                  Container(width: 24.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _launch.missionName,
                        style: TextStyle(
                            fontSize: 21.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Flight #${_launch.missionNumber}',
                        style: TextStyle(fontSize: 17.0),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      InkWell(
                        onTap: () => dialogBuilder(context,
                            _launch.missionLaunchSite, _getLaunchPadDialog()),
                        child: Text(_launch.missionLaunchSite,
                            style: TextStyle(
                                fontSize: 17.0,
                                decoration: TextDecoration.underline)),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        _launch.getDate(),
                        style: TextStyle(fontSize: 17.0),
                      ),
                    ],
                  )
                ],
              ),
              Divider(
                height: 24.0,
              ),
              Text(
                _launch.getDetails(),
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
  final BuildContext context;

  _FirstStageCard(this.context, this.rocket);

  /* Future<Null> _getRocketPage() async {
    Navigator.push(context,
          CupertinoPageRoute(builder: (context) => LaunchPage(_launch)));
  }


  Widget _getCoreDialog() {
    return Text("core");
  }
  */

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(24.0),
            child: Text(
              'ROCKET',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.0),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                rowClickableItem(
                    context, 'Rocket name', rocket.getName()),
                SizedBox(
                  height: 12.0,
                ),
                rowItem('Rocket type', rocket.getType()),
                Column(
                  children:
                      rocket.getFirstStage().map((m) => _getCores(m)).toList(),
                )
                //_refurbishItem('Fairings', launch.fairingReused),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getCores(Core core) {
    Widget _getLandingData() {
      if (core.getLandingZone() != 'Unknown')
        return (Column(
          children: <Widget>[
            rowItem('Landing zone', core.getLandingZone()),
            SizedBox(
              height: 12.0,
            ),
            rowIconItem('Landing success', core.isLandingSuccess())
          ],
        ));
      else
        return rowIconItem('Landing attempt', core.getLandingZone() == null);
    }

    return Column(
      children: <Widget>[
        Divider(
          height: 24.0,
        ),
        rowClickableItem(context, 'Core serial', core.getId()),
        SizedBox(
          height: 12.0,
        ),
        rowItem('Core block', core.getBlock()),
        SizedBox(
          height: 12.0,
        ),
        rowItem('Total flights', core.getFlights()),
        SizedBox(
          height: 12.0,
        ),
        _getLandingData(),
      ],
    );
  }
}

class _SecondStageCard extends StatelessWidget {
  final SecondStage secondStage;
  final BuildContext context;

  _SecondStageCard(this.context, this.secondStage);

  /*Widget _getDragonDialog() {
    return Text('Dragon');
  }
  */

  @override
  Widget build(BuildContext context) {
    return Card(
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
            padding: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                rowItem('Second stage block', secondStage.getBlock()),
                SizedBox(
                  height: 12.0,
                ),
                rowItem(
                    'Total payload', secondStage.getNumberPayload().toString()),
                Column(
                  children: secondStage
                      .getPayloads()
                      .map((m) => _getPayload(m))
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

  Widget _getPayload(Payload payload) {
    Widget _getDragonSerial() {
      if (payload.getCustomer() == 'NASA (CRS)') {
        return Column(
          children: <Widget>[
            /*rowClickableItem(
                context,
                'Dragon serial',
                payload.getDragonSerial(),
                dialogBuilder(context, payload.getDragonSerial(), _getDragonDialog())),*/
            SizedBox(
              height: 12.0,
            )
          ],
        );
      } else
        return SizedBox(height: 0.0);
    }

    return Column(
      children: <Widget>[
        Divider(
          height: 24.0,
        ),
        rowItem('Payload name', payload.getId()),
        SizedBox(
          height: 12.0,
        ),
        rowItem('Payload type', payload.getPayloadType()),
        SizedBox(
          height: 12.0,
        ),
        _getDragonSerial(),
        rowItem('Customer', payload.getCustomer()),
        SizedBox(
          height: 12.0,
        ),
        rowItem('Mass', payload.getMass()),
        SizedBox(
          height: 12.0,
        ),
        rowItem('Orbit', payload.getOrbit()),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(24.0),
            child: Text(
              'REUSED PARTS',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.0),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                rowIconItem(
                    'Central booster', launch.getRocket().isCoreReused()),
                SizedBox(
                  height: 12.0,
                ),
                rowIconItem(
                    'Left booster',
                    launch.getRocket().isHeavy()
                        ? launch.getRocket().isLeftBoosterReused()
                        : null),
                SizedBox(
                  height: 12.0,
                ),
                rowIconItem(
                    'Right booster',
                    launch.getRocket().isHeavy()
                        ? launch.getRocket().isRightBoosterReused()
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

Widget rowItem(String name, String description) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(
        name,
        style: TextStyle(fontSize: 17.0),
      ),
      Text(
        description,
        style: TextStyle(fontSize: 17.0, color: Colors.white70),
      ),
    ],
  );
}

Future<Null> dialogBuilder(
    BuildContext context, String title, Widget dialog) async {
  showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            title: Text(title),
            children: <Widget>[dialog],
          ));
}

Widget rowClickableItem(
    BuildContext context, String name, String description) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(
        name,
        style: TextStyle(fontSize: 17.0),
      ),
      InkWell(
        //onTap: () => function,
        child: Text(
          description,
          style: TextStyle(
              fontSize: 17.0,
              color: Colors.white70,
              decoration: TextDecoration.underline),
        ),
      )
    ],
  );
}

Widget rowIconItem(String name, bool icon) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(
        name,
        style: TextStyle(fontSize: 17.0),
      ),
      rowIcon(icon)
    ],
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
