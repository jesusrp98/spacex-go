import 'package:flutter/material.dart';

import '../classes/launch.dart';

class DetailPage extends StatelessWidget {
  final Launch launch;

  DetailPage(this.launch);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Launch details"),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  MissionInfo(launch),
                  RocketInfo(launch),
                  PayloadInfo(launch),
                  ReusingInfo(launch)
                ],
              ),
            )
          ],
        ));
  }
}

class MissionInfo extends StatelessWidget {
  final Launch launch;

  MissionInfo(this.launch);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.network(
                    launch.getImageUrl(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(launch.missionName),
                      Text("Numer: ${launch.missionNumber}"),
                      Text(launch.getDateLocal()),
                    ],
                  )
                ],
              ),
              Container(
                height: 8.0,
              ),
              Text(
                launch.getDetails(),
                textAlign: TextAlign.justify,
              ),
            ],
          )),
    );
  }
}

class RocketInfo extends StatelessWidget {
  final Launch launch;

  RocketInfo(this.launch);

  @override
  Widget build(BuildContext context) {
    return Card(
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
            Text("-Reused?: ${launch.getCore().getReused()}"),
            Text("-Landing success?: ${launch.getCore().getLandingSuccess()}"),
          ],
        ),
      ),
    );
  }
}

class PayloadInfo extends StatelessWidget {
  final Launch launch;

  PayloadInfo(this.launch);

  @override
  Widget build(BuildContext context) {
    return Card(
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

class ReusingInfo extends StatelessWidget {
  final Launch launch;

  ReusingInfo(this.launch);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("Reusing:"),
            Text("-Fairing reused?: ${launch.fairingReused}"),
            Text("-Capsule reused?: ${launch.capsuleReused}"),
            Text("Site name: ${launch.siteName}"),
          ],
        ),
      ),
    );
  }
}
