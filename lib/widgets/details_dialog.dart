import 'package:cherry/classes/core_details.dart';
import 'package:cherry/classes/dragon_details.dart';
import 'package:cherry/classes/launchpad_info.dart';
import 'package:cherry/widgets/row_item.dart';
import 'package:cherry/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

//TODO impelent dialog caching
class DetailsDialog extends StatelessWidget {
  final int type;
  final Function buildDialog;
  final String id;
  final String title;

  DetailsDialog({this.type, this.buildDialog, this.id, this.title});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(title),
      contentPadding: const EdgeInsets.all(24.0),
      children: <Widget>[
        _getDialogInfo(_getDialogDetails(type, id), buildDialog),
      ],
    );
  }

  factory DetailsDialog.launchpad(String id, String title) {
    return DetailsDialog(
      type: 0,
      buildDialog: _buildLaunchPadDialog,
      id: id,
      title: title,
    );
  }

  factory DetailsDialog.core(String id, String title) {
    return DetailsDialog(
      type: 1,
      buildDialog: _buildCoreDialog,
      id: id,
      title: title,
    );
  }

  factory DetailsDialog.dragon(String id, String title) {
    return DetailsDialog(
      type: 2,
      buildDialog: _buildDragonDialog,
      id: id,
      title: title,
    );
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

  static Widget _buildLaunchPadDialog(LaunchpadInfo launchpad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 24.0, left: 24.0, bottom: 8.0),
          child: Text(launchpad.name, textAlign: TextAlign.center),
        ),
        RowItem.textRow('Status', launchpad.getStatus),
        const SizedBox(
          height: 8.0,
        ),
        RowItem.textRow('Location', launchpad.locationName),
        const SizedBox(
          height: 8.0,
        ),
        RowItem.textRow('Coordenates', launchpad.getCoordinates),
        const Divider(
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

  static Widget _buildCoreDialog(CoreDetails core) {
    return Column(
      children: <Widget>[
        RowItem.textRow('Core block', core.getBlock),
        const SizedBox(
          height: 8.0,
        ),
        RowItem.textRow('Status', core.getStatus),
        const SizedBox(
          height: 8.0,
        ),
        RowItem.textRow('First launched', core.getFirstLaunched),
        const SizedBox(
          height: 8.0,
        ),
        RowItem.textRow('Landings', core.landings.toString()),
        const Divider(
          height: 24.0,
        ),
        Text(
          core.getDetails,
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 15.0),
        ),
      ],
    );
  }

  static Widget _buildDragonDialog(DragonDetails dragon) {
    return Column(
      children: <Widget>[
        RowItem.textRow('Capsule model', dragon.name),
        const SizedBox(
          height: 8.0,
        ),
        RowItem.textRow('Status', dragon.getStatus),
        const SizedBox(
          height: 8.0,
        ),
        RowItem.textRow('First launched', dragon.getFirstLaunched),
        const SizedBox(
          height: 8.0,
        ),
        RowItem.textRow('Landings', dragon.landings.toString()),
        const Divider(
          height: 24.0,
        ),
        Text(
          dragon.getDetails,
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 15.0),
        ),
      ],
    );
  }
}
