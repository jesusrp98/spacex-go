import 'package:flutter/material.dart';

import '../classes/rocket_info.dart';

class RocketPage extends StatelessWidget {
  final RocketInfo rocket;

  RocketPage(this.rocket);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Rocket details'),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _RocketCard(rocket),
                  _SpecificationsCard(rocket),
                  _PayloadsCard(rocket),
                  _EnginesCard(rocket),
                ],
              ),
            )
          ],
        ));
  }
}

class _RocketCard extends StatelessWidget {
  final RocketInfo rocket;

  _RocketCard(this.rocket);

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
                  //_launch.getHeroImage(128.0),
                  Container(width: 24.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        rocket.name,
                        style: TextStyle(
                            fontSize: 21.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      rowItem('First launched', rocket.getFirstLaunched),
                      SizedBox(
                        height: 8.0,
                      ),
                      rowItem('Success rate', rocket.getSuccessRate),
                      SizedBox(
                        height: 8.0,
                      ),
                      rowItem('Launch cost', rocket.getLaunchCost),
                    ],
                  )
                ],
              ),
              Divider(
                height: 24.0,
              ),
              Text(
                rocket.details,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15.0),
              ),
            ],
          )),
    );
  }
}

class _SpecificationsCard extends StatelessWidget {
  final RocketInfo rocket;

  _SpecificationsCard(this.rocket);

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
              'SPECIFICATIONS',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.0),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                rowIconItem('Active', rocket.isActive),
                SizedBox(
                  height: 12.0,
                ),
                rowItem('Rocket stages', rocket.getStages),
                SizedBox(
                  height: 12.0,
                ),
                rowItem('Height', rocket.getHeight),
                SizedBox(
                  height: 12.0,
                ),
                rowItem('Diameter', rocket.getDiameter),
                SizedBox(
                  height: 12.0,
                ),
                rowItem('Total mass', rocket.getMass),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _PayloadsCard extends StatelessWidget {
  final RocketInfo rocket;

  _PayloadsCard(this.rocket);

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
              'PAYLOAD',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.0),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 24.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: rocket.payloadWeights
                    .map((payloadWeight) => getPayloadWeight(payloadWeight))
                    .toList()),
          )
        ],
      ),
    );
  }

  Widget getPayloadWeight(PayloadWeight payloadWeight) {
    return rowItem(payloadWeight.name, payloadWeight.getMass);
  }
}

class _EnginesCard extends StatelessWidget {
  final RocketInfo rocket;

  _EnginesCard(this.rocket);

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
              'ENGINES',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.0),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                rowItem('Engine model', rocket.getEngine),
                SizedBox(
                  height: 12.0,
                ),
                rowItem('First stage engines',
                    rocket.engineConfiguration[0].toString()),
                SizedBox(
                  height: 12.0,
                ),
                rowItem('Second stage engines',
                    rocket.engineConfiguration[1].toString()),
                SizedBox(
                  height: 12.0,
                ),
                rowItem('Sea level thrust', rocket.getEngineThrustSea),
                SizedBox(
                  height: 12.0,
                ),
                rowItem('Vacuum thrust', rocket.getEngineThrustVacuum),
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

Widget rowIcon(bool state) {
  return Icon(
    state == null
        ? Icons.remove_circle
        : (state ? Icons.check_circle : Icons.cancel),
    color:
        state == null ? Colors.blueGrey : (state ? Colors.green : Colors.red),
  );
}
