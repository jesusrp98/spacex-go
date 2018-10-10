import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../classes/capsule_details.dart';
import '../classes/core_details.dart';
import '../classes/launchpad_info.dart';
import '../colors.dart';
import '../url.dart';
import 'row_item.dart';

/// DETAILS DIALOG CLASS
/// Builds a custom dialog, which can be a launchpad, core or capsule dialog.
class DetailsDialog extends StatelessWidget {
  final int type;
  final Function buildBody;
  final String id, title;

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
          style: Theme.of(context)
              .textTheme
              .title
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      children: <Widget>[
        _getBody(future: _getDialogItem(type, id), build: buildBody),
      ],
    );
  }

  /// Builds a launchpad dialog
  factory DetailsDialog.launchpad({String id, String title}) {
    return DetailsDialog(
      type: 0,
      buildBody: _launchpadDialog,
      id: id,
      title: title,
    );
  }

  /// Builds a core dialog
  factory DetailsDialog.core({String id, String title}) {
    return DetailsDialog(
      type: 1,
      buildBody: _coreDialog,
      id: id,
      title: title,
    );
  }

  /// Builds a capsule dialog
  factory DetailsDialog.capsule({String id, String title}) {
    return DetailsDialog(
      type: 2,
      buildBody: _capsuleDialog,
      id: id,
      title: title,
    );
  }

  /// Builds the dialog's body based on the fetched information
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

  /// Fetches the information needed to build the dialog
  Future _getDialogItem(int type, String serial) async {
    final response = await http.get(Url.detailsPage[type] + serial);
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

  /// Builds the body of the dialog with the launchpad info
  static Widget _launchpadDialog(LaunchpadInfo launchpad) {
    return _buildBody(
      body: Column(children: <Widget>[
        Text(
          launchpad.name,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 17.0, color: primaryText),
        ),
        const SizedBox(height: 8.0),
        RowItem.textRow('Status', launchpad.getStatus),
        const SizedBox(height: 8.0),
        RowItem.textRow('Location', launchpad.location),
        const SizedBox(height: 8.0),
        RowItem.textRow('State', launchpad.state),
        const SizedBox(height: 8.0),
        RowItem.textRow('Coordinates', launchpad.getCoordinates)
      ]),
      details: launchpad.details,
    );
  }

  /// Builds the body of the dialog with the core info
  static Widget _coreDialog(CoreDetails core) {
    return _buildBody(
      body: Column(children: <Widget>[
        RowItem.textRow('Model', core.getBlock),
        const SizedBox(height: 8.0),
        RowItem.textRow('Status', core.getStatus),
        const SizedBox(height: 8.0),
        RowItem.textRow('First launched', core.getFirstLaunched),
        const SizedBox(height: 8.0),
        RowItem.textRow('Launches', core.getLaunches),
        const SizedBox(height: 8.0),
        RowItem.textRow('RTLS landings', core.getRtlsLandings),
        const SizedBox(height: 8.0),
        RowItem.textRow('ASDS landings', core.getAsdsLandings),
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

  /// Builds the body of the dialog with the capsule info
  static Widget _capsuleDialog(CapsuleDetails capsule) {
    return _buildBody(
      body: Column(children: <Widget>[
        RowItem.textRow('Model', capsule.name),
        const SizedBox(height: 8.0),
        RowItem.textRow('Status', capsule.getStatus),
        const SizedBox(height: 8.0),
        RowItem.textRow('First launched', capsule.getFirstLaunched),
        const SizedBox(height: 8.0),
        RowItem.textRow('Launches', capsule.getLaunches),
        const SizedBox(height: 8.0),
        RowItem.textRow('Splashings', capsule.getLandings),
        const SizedBox(height: 8.0),
        Text(
          capsule.getMissions,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 17.0, color: primaryText),
        ),
      ]),
      details: capsule.getDetails,
    );
  }

  /// Aux method to build the dialog's body
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
