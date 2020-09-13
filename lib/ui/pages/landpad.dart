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
  final String launchId;
  final String coreId;

  const LandpadPage({
    Key key,
    this.launchId,
    this.coreId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final landpad = context
        .watch<LaunchesRepository>()
        .getLaunch(launchId)
        .rocket
        .getCore(coreId)
        .landpad;

    return Scaffold(
      body: SliverPage.map(
        title: landpad.name,
        coordinates: landpad.coordinates,
        body: <Widget>[
          SliverSafeArea(
            top: false,
            sliver: SliverToBoxAdapter(
              child: RowLayout.body(children: <Widget>[
                Text(
                  landpad.fullName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme)
                      .subtitle1,
                ),
                RowText(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.pad.status',
                  ),
                  landpad.getStatus,
                ),
                RowText(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.pad.location',
                  ),
                  landpad.locality
                ),
                RowText(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.pad.state',
                  ),
                  landpad.region,
                ),
                RowText(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.pad.coordinates',
                  ),
                  landpad.getCoordinates,
                ),
                RowText(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.pad.landing_type',
                  ),
                  landpad.type,
                ),
                RowText(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.pad.landings_successful',
                  ),
                  landpad.getSuccessfulLandings,
                ),
                Separator.divider(),
                // TODO
                // TextExpand(landpad.details)
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
