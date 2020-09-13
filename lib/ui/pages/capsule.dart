import 'package:cherry_components/cherry_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';

import '../../repositories/index.dart';
import '../../util/photos.dart';
import '../widgets/index.dart';

/// This view displays information about a specific capsule,
/// used in a NASA mission.
class CapsulePage extends StatelessWidget {
  final String launchId;

  const CapsulePage({Key key, this.launchId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final capsule = context
        .watch<LaunchesRepository>()
        .getLaunch(launchId)
        .rocket
        .getSinglePayload
        .capsule;

    return Scaffold(
      body: SliverPage.slides(
        title: FlutterI18n.translate(
          context,
          'spacex.dialog.vehicle.title_capsule',
          translationParams: {'serial': capsule.serial},
        ),
        slides: List.from(SpaceXPhotos.capsules)..shuffle(),
        body: <Widget>[
          SliverSafeArea(
            top: false,
            sliver: SliverToBoxAdapter(
              child: RowLayout.body(children: <Widget>[
                RowText(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.vehicle.model',
                  ),
                  capsule.serial,
                ),
                RowText(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.vehicle.status',
                  ),
                  capsule.getStatus,
                ),
                RowText(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.vehicle.first_launched',
                  ),
                  capsule.getFirstLaunched(context),
                ),
                RowText(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.vehicle.launches',
                  ),
                  capsule.getLaunches,
                ),
                RowText(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.vehicle.splashings',
                  ),
                  capsule.getSplashings,
                ),
                Separator.divider(),
                if (capsule.hasMissions) ...[
                  for (final launch in capsule.launches)
                    RowText(
                      FlutterI18n.translate(
                        context,
                        'spacex.dialog.vehicle.mission',
                        translationParams: {
                          'number': launch.flightNumber.toString()
                        },
                      ),
                      launch.name,
                    ),
                  Separator.divider()
                ],
                TextExpand(capsule.getDetails(context))
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
