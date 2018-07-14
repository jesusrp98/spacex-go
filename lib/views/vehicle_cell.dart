import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../classes/rocket_info.dart';
import '../classes/dragon_info.dart';
import '../classes/vehicle.dart';
import 'rocket_page.dart';
import 'dragon_page.dart';

class VehicleCell extends StatelessWidget {
  final RocketInfo rocket;
  final DragonInfo dragon;

  VehicleCell({this.rocket, this.dragon});

  @override
  Widget build(BuildContext context) {
    final Vehicle vehicle = (rocket != null) ? rocket : dragon;
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: FlatButton(
          padding: EdgeInsets.all(16.0),
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => (rocket != null)
                        ? RocketPage(rocket)
                        : DragonPage(dragon)));
          },
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        //vehicle.getHeroImage(82.0),
                        Container(width: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              vehicle.name,
                              style: TextStyle(
                                  fontSize: 21.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              vehicle.id,
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
