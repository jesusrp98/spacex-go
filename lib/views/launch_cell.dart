import 'package:flutter/material.dart';

import '../classes/launch.dart';
import 'details_page.dart';

class LaunchCell extends StatelessWidget {
  final Launch _launch;

  LaunchCell(this._launch);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: FlatButton(
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
                    Row(
                      children: <Widget>[
                        _launch.getHeroImage(82.0),
                        Container(width: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _launch.missionName,
                              style: TextStyle(
                                  fontSize: 21.0, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              height: 8.0,
                            ),
                            Text(
                              _launch.getDate(),
                              style: TextStyle(fontSize: 17.0),
                            ),
                          ],
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