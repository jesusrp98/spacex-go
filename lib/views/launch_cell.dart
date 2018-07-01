import 'package:flutter/material.dart';

import '../classes/launch.dart';

class LaunchCell extends StatelessWidget {
  final Launch _launch;

  LaunchCell(this._launch);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailPage(_launch)));
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Text(
                  _launch.missionName,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Text(_launch.getDateLocal()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Launch launch;

  DetailPage(this.launch);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Launch details"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  _MissionInfo(launch),
                  Text(launch.getDetails()),
                  _RocketInfo(launch),
                  Text("Rocket name: ${launch.rocketName}"),
                  Text("First stage:"),
                  Text("-Core ID: ${launch.getCore().getId()}"),
                  Text("-No. flights: ${launch.getCore().getFlights()}"),
                  Text("-Core block: ${launch.getCore().getBlock()}"),
                  Text("-Reused?: ${launch.getCore().getReused()}"),
                  Text(
                      "-Landing success?: ${launch.getCore().getLandingSuccess()}"),
                  Text("-Landing zone: ${launch.getCore().getLandingZone()}"),
                  Text("Second stage"),
                  Text("-Stage block: ${launch.secondStage.getBlock()}"),
                  Text("Payload:"),
                  Text(
                      "-Payload ID: ${launch.secondStage.getPayload().getId()}"),
                  Text(
                      "-Payload customer: ${launch.secondStage.getPayload().getCustomer()}"),
                  Text(
                      "-Payload mass: ${launch.secondStage.getPayload().getMass()}kg"),
                  Text(
                      "-Payload orbit: ${launch.secondStage.getPayload().getOrbit()}"),
                  Text("Reusing:"),
                  Text("-Fairing reused?: ${launch.fairingReused}"),
                  Text("-Capsule reused?: ${launch.capsuleReused}"),
                  Text("Site name: ${launch.siteName}"),
                ],
              ))
        ],
      ),
    );
  }
}

class _MissionInfo extends StatelessWidget {
  final Launch launch;

  _MissionInfo(this.launch);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        launch.getImage(),
        Column(
          children: <Widget>[
            Text(launch.missionName),
            Text("No: ${launch.missionNumber}"),
            Text(launch.getDateLocal()),
          ],
        )
      ],
    );
  }
}

class _RocketInfo extends StatelessWidget {
  final Launch launch;

  _RocketInfo(this.launch);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
