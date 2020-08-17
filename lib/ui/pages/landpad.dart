import 'package:cherry_components/cherry_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';

import '../../repositories/index.dart';
import '../widgets/index.dart';

/// This view displays information about a specific landpad,
/// where rockets now land.
class LandpadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LandpadRepository>(
      builder: (context, model, child) => Scaffold(
        body: SliverPage<LandpadRepository>.map(
          title: model.id,
          coordinates: model.landpad?.coordinates,
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
    return Consumer<LandpadRepository>(
      builder: (context, model, child) => RowLayout.body(children: <Widget>[
        Text(
          model.landpad.name,
          textAlign: TextAlign.center,
          style:
              GoogleFonts.rubikTextTheme(Theme.of(context).textTheme).subtitle1,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.dialog.pad.status',
          ),
          model.landpad.getStatus,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.dialog.pad.location',
          ),
          model.landpad.location,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.dialog.pad.state',
          ),
          model.landpad.state,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.dialog.pad.coordinates',
          ),
          model.landpad.getCoordinates,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.dialog.pad.landing_type',
          ),
          model.landpad.type,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.dialog.pad.landings_successful',
          ),
          model.landpad.getSuccessfulLandings,
        ),
        Separator.divider(),
        TextExpand(model.landpad.details)
      ]),
    );
  }
}
