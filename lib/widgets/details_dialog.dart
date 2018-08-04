import 'package:cherry/classes/capsule_details.dart';
import 'package:cherry/classes/core_details.dart';
import 'package:cherry/classes/launchpad_info.dart';
import 'package:cherry/colors.dart';
import 'package:cherry/widgets/row_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

class DetailsDialog extends StatelessWidget {
  final int type;
  final Function buildBody;
  final String id;
  final String title;

  static List URL = [
    'https://api.spacexdata.com/v2/launchpads/',
    'https://api.spacexdata.com/v2/parts/cores/',
    'https://api.spacexdata.com/v2/parts/caps/',
  ];

  DetailsDialog({
    this.type,
    this.buildBody,
    this.id,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(24.0),
      title: Container(
        alignment: Alignment.center,
        child: Text(
          title,
          style: Theme
              .of(context)
              .textTheme
              .title
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      children: <Widget>[
        Container(
          child: _getBody(future: _getDialogItem(type, id), build: buildBody),
        ),
      ],
    );
  }

  factory DetailsDialog.launchpad(String id, String title) {
    return DetailsDialog(
      type: 0,
      buildBody: _launchpadDialog,
      id: id,
      title: title,
    );
  }

  factory DetailsDialog.core(String id, String title) {
    return DetailsDialog(
      type: 1,
      buildBody: _coreDialog,
      id: id,
      title: title,
    );
  }

  factory DetailsDialog.dragon(String id, String title) {
    return DetailsDialog(
      type: 2,
      buildBody: _dragonDialog,
      id: id,
      title: title,
    );
  }

  Widget _getBody({Future future, Function build}) {
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

  Future _getDialogItem(int type, String serial) async {
    final response = await http.get(URL[type] + serial);
    final Map<String, dynamic> jsonDecoded = json.decode(response.body);

    switch (type) {
      case 0:
        return LaunchpadInfo.fromJson(jsonDecoded);
      case 1:
        return CoreDetails.fromJson(jsonDecoded);
      default:
        return CapsuleDetails.fromJson(jsonDecoded);
    }
  }

  static Widget _launchpadDialog(LaunchpadInfo launchpad) {
    return _buildBody(
      body: Column(children: <Widget>[
        Text(launchpad.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17.0, color: primaryText)),
        const SizedBox(height: 8.0),
        RowItem.textRow('Status', launchpad.getStatus),
        const SizedBox(height: 8.0),
        RowItem.textRow('Location', launchpad.location),
        const SizedBox(height: 8.0),
        RowItem.textRow('State', launchpad.state),
        const SizedBox(height: 8.0),
        RowItem.textRow('Coordenates', launchpad.getCoordinates)
      ]),
      details: launchpad.details,
    );
  }

  static Widget _coreDialog(CoreDetails core) {
    return _buildBody(
      body: Column(children: <Widget>[
        const SizedBox(height: 8.0),
        RowItem.textRow('Core block', core.getBlock),
        const SizedBox(height: 8.0),
        RowItem.textRow('Status', core.getStatus),
        const SizedBox(height: 8.0),
        RowItem.textRow('First launched', core.getFirstLaunched),
        const SizedBox(height: 8.0),
        RowItem.textRow('Landings', core.landings.toString()),
        const SizedBox(height: 8.0),
        Text(
          core.getMissions,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 17.0, color: primaryText),
        ),
      ]),
      details: core.getDetails,
    );
  }

  static Widget _dragonDialog(CapsuleDetails capsule) {
    return _buildBody(
      body: Column(children: <Widget>[
        RowItem.textRow('Capsule model', capsule.name),
        const SizedBox(height: 8.0),
        RowItem.textRow('Status', capsule.getStatus),
        const SizedBox(height: 8.0),
        RowItem.textRow('First launched', capsule.getFirstLaunched),
        const SizedBox(height: 8.0),
        RowItem.textRow('Landings', capsule.landings.toString()),
      ]),
      details: capsule.getDetails,
    );
  }

  static Widget _buildBody({Widget body, String details}) {
    return Column(children: <Widget>[
      body,
      const Divider(height: 24.0),
      Text(
        details,
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 15.0, color: secondaryText),
      ),
    ]);
  }
}
