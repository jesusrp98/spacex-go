import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';

import '../../data/models/index.dart';
import '../widgets/index.dart';

/// This view displays information about a specific launchpad,
/// where rockets get rocketed to the sky...
class LaunchpadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LaunchpadModel>(
      builder: (context, model, child) => Scaffold(
        body: SliverPage<LaunchpadModel>.map(
          title: model.name,
          coordinates: model.launchpad?.coordinates,
          body: <Widget>[
            SliverToBoxAdapter(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Consumer<LaunchpadModel>(
      builder: (context, model, child) => RowLayout.body(children: <Widget>[
        Text(
          model.launchpad.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'ProductSans',
          ),
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.dialog.pad.status',
          ),
          model.launchpad.getStatus,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.dialog.pad.location',
          ),
          model.launchpad.location,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.dialog.pad.state',
          ),
          model.launchpad.state,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.dialog.pad.coordinates',
          ),
          model.launchpad.getCoordinates,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.dialog.pad.launches_successful',
          ),
          model.launchpad.getSuccessfulLaunches,
        ),
        Separator.divider(),
        TextExpand(
          model.launchpad.details,
        )
      ]),
    );
  }
}
