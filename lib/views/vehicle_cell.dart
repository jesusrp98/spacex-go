import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../classes/vehicle.dart';
import '../classes/rocket_info.dart';
import 'rocket_page.dart';
import 'capsule_page.dart';

class VehicleCell extends StatelessWidget {
  final Vehicle vehicle;

  VehicleCell(this.vehicle);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: FlatButton(
          padding: EdgeInsets.all(16.0),
          onPressed: () {
            Navigator.push(context, CupertinoPageRoute(builder: (context) {
              if (vehicle is RocketInfo)
                //RocketPage(vehicle);
                print("ola");
              else
                CapsulePage(vehicle);
            }));
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
                              vehicle.isActive.toString(),
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
