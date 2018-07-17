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
        elevation: 8.0,
        margin: const EdgeInsets.only(bottom: 16.0),
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
                        Container(
                          height: 82.0,
                          width: 82.0,
                          child: Hero(
                            tag: rocket != null ? rocket.id : dragon.id,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: NetworkImage(
                                          'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/falcon9.jpg?alt=media&token=96b5c764-a2ea-43f0-8766-1761db1749d4'))),
                            ),
                          ),
                        ),
                        Container(width: 14.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                vehicle.name,
                                style: TextStyle(
                                    fontSize: 21.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                vehicle.getDescription,
                                style: TextStyle(fontSize: 17.0),
                              ),
                            ],
                          ),
                        ),
                        Container(width: 8.0),
                        Container(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(
                            (vehicle.isActive)
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: Colors.white70,
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
