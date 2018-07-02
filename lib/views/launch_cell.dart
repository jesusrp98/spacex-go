import 'package:flutter/material.dart';

import '../classes/launch.dart';
import 'details_page.dart';

class LaunchCell extends StatelessWidget {
  final Launch _launch;

  LaunchCell(this._launch);

  @override
  Widget build(BuildContext context) {
    return Card(
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
    ));
  }
}
