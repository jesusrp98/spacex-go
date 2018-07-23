import 'package:flutter/material.dart';

class ListCell extends StatelessWidget {
  final Widget image;
  final String title;
  final String subtitle;
  final Widget lateralWidget;
  final Function onClick;

  ListCell(
      {this.image,
      this.title,
      this.subtitle,
      this.lateralWidget,
      this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6.0,
        margin: const EdgeInsets.only(bottom: 16.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: FlatButton(
          padding: const EdgeInsets.all(14.0),
          onPressed: onClick,
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        image,
                        Container(width: 14.0),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  title,
                                  style: TextStyle(
                                      fontSize: 21.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  height: 12.0,
                                ),
                                Text(
                                  subtitle,
                                  style: TextStyle(fontSize: 17.0),
                                ),
                              ]),
                        ),
                        Container(width: 8.0),
                        lateralWidget
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class MissionNumber extends StatelessWidget {
  final String missionNumber;

  MissionNumber(this.missionNumber);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 8.0),
      child: Text(
        missionNumber,
        style: TextStyle(color: Colors.white70, fontSize: 24.0),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class VehicleState extends StatelessWidget {
  final bool status;

  VehicleState(this.status);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 8.0),
      child: Icon(
        (status) ? Icons.check_circle : Icons.cancel,
        color: Colors.white70,
      ),
    );
  }
}
