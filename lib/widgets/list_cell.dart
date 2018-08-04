import 'package:flutter/material.dart';
import 'package:cherry/colors.dart';

class ListCell extends StatelessWidget {
  final Widget leading;
  final String title;
  final String subtitle;
  final Widget trailing;
  final VoidCallback onTap;

  ListCell({
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(16.0),
      leading: leading,
      title: Column(
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
          Container(height: 8.0),
        ],
      ),
      subtitle: Text(
        subtitle,
        style:
            Theme.of(context).textTheme.subhead.copyWith(color: secondaryText),
      ),
      trailing: trailing,
      onTap: onTap,
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

class VehicleStatus extends StatelessWidget {
  final bool status;

  VehicleStatus(this.status);

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
