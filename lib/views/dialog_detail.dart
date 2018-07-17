import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import '../classes/launchpad_info.dart';
import '../classes/core_details.dart';
import '../classes/dragon_details.dart';
import '../classes/row_item.dart';
import '../url.dart';

class DialogDetail extends StatelessWidget {
  final int type;
  final String id;
  final String title;

  DialogDetail({this.type, this.id, this.title});

  @override
  Widget build(BuildContext context) {
    Function buildDialog;

    if (type == 0)
      buildDialog = _buildLaunchPadDialog;
    else if (type == 1)
      buildDialog = _buildCoreDialog;
    else
      buildDialog = _buildDragonDialog;

    return SimpleDialog(
      title: Text(title),
      contentPadding: const EdgeInsets.all(24.0),
      children: <Widget>[
        _getDialogInfo(_getDialogDetails(type, id), buildDialog),
      ],
    );
  }
}

Future _getDialogDetails(int type, String serial) async {
  final response = await http.get(Url.DETAILS[type] + serial);
  final Map<String, dynamic> jsonDecoded = json.decode(response.body);

  if (type == 0)
    return LaunchpadInfo.fromJson(jsonDecoded);
  else if (type == 1)
    return CoreDetails.fromJson(jsonDecoded);
  else
    return DragonDetails.fromJson(jsonDecoded);
}

Widget _getDialogInfo(Future future, Function build) {
  return Center(
    child: FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          default:
            if (!snapshot.hasError)
              return build(snapshot.data);
            else
              return const Text("Couldn't connect to server...");
        }
      },
    ),
  );
}

Widget _buildLaunchPadDialog(LaunchpadInfo launchpad) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: 24.0, left: 24.0, bottom: 8.0),
        child: Text(launchpad.name, textAlign: TextAlign.center),
      ),
      RowItem.textRow('Status', launchpad.getStatus),
      SizedBox(
        height: 8.0,
      ),
      RowItem.textRow('Location', launchpad.locationName),
      SizedBox(
        height: 8.0,
      ),
      RowItem.textRow('Coordenates', launchpad.getCoordinates),
      Divider(
        height: 24.0,
      ),
      Text(
        launchpad.details,
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 15.0),
      ),
    ],
  );
}

Widget _buildCoreDialog(CoreDetails core) {
  return Column(
    children: <Widget>[
      RowItem.textRow('Core block', core.getBlock),
      SizedBox(
        height: 8.0,
      ),
      RowItem.textRow('Status', core.getStatus),
      SizedBox(
        height: 8.0,
      ),
      RowItem.textRow('First launched', core.getFirstLaunched),
      SizedBox(
        height: 8.0,
      ),
      RowItem.textRow('Landings', core.landings.toString()),
      Divider(
        height: 24.0,
      ),
      Text(
        core.details,
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 15.0),
      ),
    ],
  );
}

Widget _buildDragonDialog(DragonDetails dragon) {
  return Column(
    children: <Widget>[
      RowItem.textRow('Capsule model', dragon.name),
      SizedBox(
        height: 8.0,
      ),
      RowItem.textRow('Status', dragon.getStatus),
      SizedBox(
        height: 8.0,
      ),
      RowItem.textRow('First launched', dragon.getFirstLaunched),
      SizedBox(
        height: 8.0,
      ),
      RowItem.textRow('Landings', dragon.landings.toString()),
      Divider(
        height: 24.0,
      ),
      Text(
        dragon.details,
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 15.0),
      ),
    ],
  );
}
