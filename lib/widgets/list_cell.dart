import 'package:flutter/material.dart';
import 'package:cherry/colors.dart';

class ListCell extends StatelessWidget {
  final Widget image;
  final String title;
  final String subtitle;
  final Widget lateralWidget;
  final VoidCallback onClick;

  ListCell(
      {this.image,
      this.title,
      this.subtitle,
      this.lateralWidget,
      this.onClick});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      onPressed: onClick,
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    image,
                    Container(width: 16.0),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              title,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .title
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Container(
                              height: 8.0,
                            ),
                            Text(subtitle,
                                style: Theme.of(context).textTheme.subhead.copyWith(
                                  color: secondaryText
                                )),
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
    );
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
        style: Theme.of(context).textTheme.title.copyWith(color: lateralText),
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
        color: lateralText,
      ),
    );
  }
}
