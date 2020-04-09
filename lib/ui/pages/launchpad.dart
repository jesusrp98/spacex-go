import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';

import '../../repositories/index.dart';
import '../widgets/index.dart';

/// This view displays information about a specific launchpad,
/// where rockets get rocketed to the sky...
class LaunchpadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LaunchpadRepository>(
      builder: (context, model, child) => Scaffold(
        body: SliverPage<LaunchpadRepository>.map(
          title: model.name,
          coordinates: model.launchpad?.coordinates,
          body: <Widget>[
            SliverSafeArea(
              top: false,
              sliver: SliverToBoxAdapter(
                child: _buildBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Consumer<LaunchpadRepository>(
      builder: (context, model, child) => RowLayout.body(children: <Widget>[
        Text(
          model.launchpad.name,
          textAlign: TextAlign.center,
          style:
              GoogleFonts.rubikTextTheme(Theme.of(context).textTheme).subtitle1,
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
