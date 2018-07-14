import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../classes/launch.dart';
import 'launch_page.dart';

class LaunchCell extends StatelessWidget {
  final Launch _launch;

  LaunchCell(this._launch);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6.0,
        margin: const EdgeInsets.only(bottom: 16.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: FlatButton(
          padding: const EdgeInsets.all(14.0),
          onPressed: () => Navigator.push(context,
              CupertinoPageRoute(builder: (context) => LaunchPage(_launch))),
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _launch.getHeroImage(82.0),
                        Container(width: 14.0),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _launch.missionName,
                                  style: TextStyle(
                                      fontSize: 21.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  height: 12.0,
                                ),
                                Text(
                                  _launch.getDate(),
                                  style: TextStyle(fontSize: 17.0),
                                ),
                              ]),
                        ),
                        Container(width: 8.0),
                        Container(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Text(
                            _launch.getMissionNumber,
                            style: TextStyle(
                                color: Colors.white70, fontSize: 24.0),
                            textAlign: TextAlign.center,
                          ),
                        )
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
