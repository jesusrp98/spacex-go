import 'package:flutter/material.dart';

import '../classes/launch.dart';

class DetailPage extends StatelessWidget {
  final Launch launch;

  DetailPage(this.launch);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Launch details'),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _MissionCard(launch),
                  _ReusingCard(launch),
                  _RocketCard(launch),
                  _PayloadCard(launch),
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
                _launch.getMissionDetails(),
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15.0),
              ),
            ],
          )),
    );
  }
}

class _RocketCard extends StatelessWidget {
  final Launch launch;

  _RocketCard(this.launch);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("Rocket name: ${launch.rocketName}"),
            Text("First stage:"),
            Text("-Core ID: ${launch.getCore().getId()}"),
            Text("-No. flights: ${launch.getCore().getFlights()}"),
            Text("-Core block: ${launch.getCore().getBlock()}"),
            Text("-Reused?: ${launch.getCore().isReused()}"),
            Text("-Landing success?: ${launch.getCore().isLandingSuccess()}"),
          ],
        ),
      ),
    );
  }
}

class _PayloadCard extends StatelessWidget {
  final Launch launch;

  _PayloadCard(this.launch);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("Second stage"),
            Text("-Stage block: ${launch.secondStage.getBlock()}"),
            Text("Payload:"),
            Text("-Payload ID: ${launch.secondStage.getPayload().getId()}"),
            Text(
                "-Payload customer: ${launch.secondStage.getPayload().getCustomer()}"),
            Text(
                "-Payload mass: ${launch.secondStage.getPayload().getMass()}kg"),
            Text(
                "-Payload orbit: ${launch.secondStage.getPayload().getOrbit()}"),
          ],
        ),
      ),
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
              'REFURBISHMENT',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.0),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _refurbishItem('Central booster', launch.isCoreReused()),
                SizedBox(
                  height: 12.0,
                ),
                _refurbishItem(
                    'Left booster',
                    launch.isHeavyMission()
                        ? launch.isLeftBoosterReused()
                        : null),
                SizedBox(
                  height: 12.0,
                ),
                _refurbishItem(
                    'Right booster',
                    launch.isHeavyMission()
                        ? launch.isRightBoosterReused()
                        : null),
                SizedBox(
                  height: 12.0,
                ),
                _refurbishItem('Dragon capsule', launch.capsuleReused),
                SizedBox(
                  height: 12.0,
                ),
                _refurbishItem('Fairings', launch.fairingReused),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _refurbishItem(String name, bool icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          name,
          style: TextStyle(fontSize: 17.0),
        ),
        _refurbishIcon(icon)
      ],
    );
  }

  Widget _refurbishIcon(bool state) {
    return Icon(
      state == null
          ? Icons.remove_circle
          : (state ? Icons.check_circle : Icons.cancel),
      color:
          state == null ? Colors.blueGrey : (state ? Colors.green : Colors.red),
    );
  }
}
