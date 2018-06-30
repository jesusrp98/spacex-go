import 'package:flutter/material.dart';
import 'package:cherry/classes/launch.dart';

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
      body: Center(
        child: Column(
          children: <Widget>[
            Image.network(launch.missionImage),
            Text("Mission name: ${launch.missionName}"),
            Text("Mission number: ${launch.missionNumber}"),
            Text("Mission date: ${launch.getDateLocal()}"),
            Text(launch.missionDetails),
            Text("Rocket name: ${launch.rocketName}"),
            Text("First stage:"),
            Text("-Core ID: ${launch.firstStage[0].id}"),
            Text("-Core block: ${launch.firstStage[0].block}"),
            Text("-Reused?: ${launch.firstStage[0].reused}"),
            Text("-Landing zone: ${launch.firstStage[0].landingZone}"),
            Text("Second stage"),
            Text("-Stage block: ${launch.secondStage.block}"),
            Text("-Fairing reused?: ${launch.fairingReused}"),
            Text("-Capsule reused?: ${launch.capsuleReused}"),
            Text("Site name: ${launch.siteName}"),
          ],
        ),
      ),
    );
  }
}
