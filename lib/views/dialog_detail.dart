import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import '../classes/launchpad_info.dart';
import '../classes/core_details.dart';
import '../classes/dragon_details.dart';
import '../url.dart' as url;
import 'launch_page.dart';

class DialogDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}

Widget buildLaunchPadDialog(LaunchpadInfo launchpad) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: 24.0, left: 24.0, bottom: 8.0),
        child: Text(launchpad.name, textAlign: TextAlign.center),
      ),
      rowItem('Status', launchpad.getStatus()),
      SizedBox(
        height: 8.0,
      ),
      rowItem('Location', launchpad.locationName),
      SizedBox(
        height: 8.0,
      ),
      rowItem('Coordenates', launchpad.getCoordinates()),
      Divider(height: 24.0),
      Padding(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: Text(
          launchpad.details,
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 15.0),
        ),
      )
    ],
  );
}

Widget buildCoreDialog(CoreDetails core) {
  return Column(
    children: <Widget>[
      rowItem('Core block', core.getBlock()),
      SizedBox(
        height: 8.0,
      ),
      rowItem('Status', core.getStatus()),
      SizedBox(
        height: 8.0,
      ),
      rowItem('First launched', core.getFirstLaunched()),
      SizedBox(
        height: 8.0,
      ),
      rowItem('Landings', core.landings.toString()),
      Divider(
        height: 24.0,
      ),
      Padding(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: Text(
          core.getDetails(),
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 15.0),
        ),
      )
    ],
  );
}

Widget buildDragonDialog(DragonDetails dragon) {
  return Column(
    children: <Widget>[
      rowItem('Capsule model', dragon.name),
      SizedBox(
        height: 8.0,
      ),
      rowItem('Status', dragon.getStatus()),
      SizedBox(
        height: 8.0,
      ),
      rowItem('First launched', dragon.getFirstLaunched()),
      SizedBox(
        height: 8.0,
      ),
      rowItem('Landings', dragon.landings.toString()),
      Divider(
        height: 24.0,
      ),
      Padding(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: Text(
          dragon.getDetails(),
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 15.0),
        ),
      )
    ],
  );
}

SimpleDialog dialogBuilder(
    BuildContext context, String title, String serial, int i, Function build) {
  return SimpleDialog(
    title: Text(title),
    contentPadding:
    const EdgeInsets.only(top: 24.0, left: 0.0, right: 0.0, bottom: 8.0),
    children: <Widget>[
      getDialogInfo(serial, i, build),
      const SizedBox(
        height: 16.0,
      ),
      Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ))
    ],
  );
}

Future getDialogDetails(int i, String serial) async {
  final response = await http.get(url.Url.DETAILS[i] + serial);

  Map<String, dynamic> jsonDecoded = json.decode(response.body);

  if (i == 0)
    return LaunchpadInfo.fromJson(jsonDecoded);
  else if (i == 1)
    return CoreDetails.fromJson(jsonDecoded);
  else
    return DragonDetails.fromJson(jsonDecoded);
}

Widget getDialogInfo(String serial, int i, Function build) {
  return Center(
    child: FutureBuilder(
      future: getDialogDetails(i, serial),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
            if (!snapshot.hasError)
              return build(snapshot.data);
            else
              return Text("Couldn't connect to server...");
        }
      },
    ),
  );
}