import 'package:cherry_components/cherry_components.dart';
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
  final String launchId;

  const LaunchpadPage({Key key, this.launchId}) : super(key: key);

  static const route = '/launchpad';

  @override
  Widget build(BuildContext context) {
    final launchpad =
        context.watch<LaunchesRepository>().getLaunch(launchId).launchpad;

    return Scaffold(
      body: SliverPage.map(
        title: launchpad.name,
        coordinates: launchpad.coordinates,
        body: <Widget>[
          SliverSafeArea(
            top: false,
            sliver: SliverToBoxAdapter(
              child: RowLayout.body(children: <Widget>[
                Text(
                  launchpad.fullName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme)
                      .subtitle1,
                ),
                RowText(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.pad.status',
                  ),
                  launchpad.getStatus,
                ),
                RowText(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.pad.location',
                  ),
                  launchpad.locality,
                ),
                RowText(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.pad.state',
                  ),
                  launchpad.region,
                ),
                RowText(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.pad.coordinates',
                  ),
                  launchpad.getCoordinates,
                ),
                RowText(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.pad.launches_successful',
                  ),
                  launchpad.getSuccessfulLaunches,
                ),
                Separator.divider(),
                TextExpand(launchpad.details)
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
