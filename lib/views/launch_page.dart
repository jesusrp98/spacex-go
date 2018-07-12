import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import '../classes/launch.dart';
import '../classes/rocket.dart';
import '../classes/core.dart';
import '../classes/second_stage.dart';
import '../classes/payload.dart';
import '../classes/core_details.dart';
import '../classes/dragon_details.dart';
import '../classes/launchpad_info.dart';
import '../url.dart' as url;

class LaunchPage extends StatelessWidget {
  final Launch launch;
  static List<String> popupItems = [
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
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _MissionCard(launch),
                  _FirstStageCard(launch.getRocket()),
                  _SecondStageCard(launch.getRocket().getSecondStage()),
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

  _MissionCard(this._launch);

  Widget buildLaunchPadDialog(LaunchpadInfo launchpad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 24.0, left: 24.0, bottom: 8.0),
          child: Text(launchpad.name, textAlign: TextAlign.center),
        ),
        rowItem('Status', launchpad.getStatus()),
        SizedBox(
          height: 8.0,
        ),
        rowItem('Location', launchpad.locationName),
        SizedBox(
          height: 8.0,
        ),
        rowItem('Coordenates', launchpad.getCoordinates()),
        Divider(height: 24.0),
        Padding(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child: Text(
            launchpad.details,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 15.0),
          ),
        )
      ],
    );
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
                        onTap: () => presentDialog(
                            context,
                            dialogBuilder(
                                context,
                                _launch.missionLaunchSite,
                                _launch.missionLaunchSiteId,
                                0,
                                buildLaunchPadDialog)),
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

presentDialog(BuildContext context, SimpleDialog dialog) {
  showDialog(context: context, builder: (context) => dialog);
}

class _FirstStageCard extends StatelessWidget {
  final Rocket rocket;

  _FirstStageCard(this.rocket);

  Widget buildCoreDialog(CoreDetails core) {
    return Column(
      children: <Widget>[
        rowItem('Core block', core.getBlock()),
        SizedBox(
          height: 8.0,
        ),
        rowItem('Status', core.getStatus()),
        SizedBox(
          height: 8.0,
        ),
        rowItem('First launched', core.getFirstLaunched()),
        SizedBox(
          height: 8.0,
        ),
        rowItem('Landings', core.landings.toString()),
        Divider(
          height: 24.0,
        ),
        Padding(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child: Text(
            core.getDetails(),
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 15.0),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
                rowClickableItem(
                    context, 'Rocket name', rocket.getName(), null),
                SizedBox(
                  height: 6.0,
                ),
                rowItem('Rocket type', rocket.getType()),
                Column(
                  children: rocket
                      .getFirstStage()
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
    Widget _getLandingData() {
      if (core.getLandingZone() != 'Unknown')
        return Column(
          children: <Widget>[
            rowItem('Landing zone', core.getLandingZone()),
            SizedBox(
              height: 12.0,
            ),
            rowIconItem('Landing success', core.isLandingSuccess())
          ],
        );
      else
        return rowIconItem('Landing attempt', core.getLandingZone() == null);
    }

    return Column(
      children: <Widget>[
        Divider(
          height: 24.0,
        ),
        rowItem('Core block', core.getBlock()),
        SizedBox(
          height: 6.0,
        ),
        rowClickableItem(
            context,
            'Core serial',
            core.getId(),
            dialogBuilder(context, 'Core ' + core.getId(), core.getId(), 1,
                buildCoreDialog)),
        SizedBox(
          height: 6.0,
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

  _SecondStageCard(this.secondStage);

  Widget buildDragonDialog(DragonDetails dragon) {
    return Column(
      children: <Widget>[
        rowItem('Capsule model', dragon.name),
        SizedBox(
          height: 8.0,
        ),
        rowItem('Status', dragon.getStatus()),
        SizedBox(
          height: 8.0,
        ),
        rowItem('First launched', dragon.getFirstLaunched()),
        SizedBox(
          height: 8.0,
        ),
        rowItem('Landings', dragon.landings.toString()),
        Divider(
          height: 24.0,
        ),
        Padding(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child: Text(
            dragon.getDetails(),
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 15.0),
          ),
        )
      ],
    );
  }

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
            padding: EdgeInsets.only(bottom: 24.0),
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
    Widget _getDragonSerial() {
      if (payload.getCustomer() == 'NASA (CRS)') {
        return Column(
          children: <Widget>[
            SizedBox(
              height: 6.0,
            ),
            rowClickableItem(
                context,
                'Dragon serial',
                payload.getDragonSerial(),
                dialogBuilder(context, payload.dragonSerial,
                    payload.dragonSerial, 2, buildDragonDialog)),
            SizedBox(
              height: 6.0,
            )
          ],
        );
      } else
        return SizedBox(height: 12.0);
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

Future getDialogDetails(int i, String serial) async {
  final response = await http.get(url.Url.DETAILS[i] + serial);

  Map<String, dynamic> jsonDecoded = json.decode(response.body);

  if (i == 0)
    return LaunchpadInfo.fromJson(jsonDecoded);
  else if (i == 1)
    return CoreDetails.fromJson(jsonDecoded);
  else
    return DragonDetails.fromJson(jsonDecoded);
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

SimpleDialog dialogBuilder(
    BuildContext context, String title, String serial, int i, Function build) {
  return SimpleDialog(
    title: Text(title),
    contentPadding:
        const EdgeInsets.only(top: 24.0, left: 0.0, right: 0.0, bottom: 8.0),
    children: <Widget>[
      getDialogInfo(serial, i, build),
      const SizedBox(
        height: 16.0,
      ),
      Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ))
    ],
  );
}

Widget rowClickableItem(BuildContext context, String name, String description,
    SimpleDialog dialog) {
  return FlatButton(
    padding: EdgeInsets.all(0.0),
    onPressed: () {
      if (description != 'Unknown') if (dialog != null)
        showDialog(context: context, builder: (context) => dialog);
      else
        print('Falcon page');
      else
        print('Unknown option');
    },
    child: rowItem(name, description, true),
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

Widget rowIcon(bool state) {
  return Icon(
    state == null
        ? Icons.remove_circle
        : (state ? Icons.check_circle : Icons.cancel),
    color:
        state == null ? Colors.blueGrey : (state ? Colors.green : Colors.red),
  );
}

Widget getDialogInfo(String serial, int i, Function build) {
  return Center(
    child: FutureBuilder(
      future: getDialogDetails(i, serial),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
            if (!snapshot.hasError)
              return build(snapshot.data);
            else
              return Text("Couldn't connect to server...");
        }
      },
    ),
  );
}
