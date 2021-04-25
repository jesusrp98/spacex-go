import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';
import 'package:row_item/row_item.dart';

import '../../../cubits/index.dart';
import '../../../utils/photos.dart';
import '../../widgets/index.dart';
import 'index.dart';

/// This view displays information about a specific capsule,
/// used in a NASA mission.
class CapsulePage extends StatelessWidget {
  final String launchId;

  const CapsulePage({Key key, this.launchId}) : super(key: key);

  static const route = '/capsule';

  @override
  Widget build(BuildContext context) {
    final capsule = context
        .watch<LaunchesCubit>()
        .getLaunch(launchId)
        .rocket
        .getSinglePayload
        .capsule;

    return Scaffold(
      body: SliverPage(
        title: FlutterI18n.translate(
          context,
          'spacex.dialog.vehicle.title_capsule',
          translationParams: {'serial': capsule.serial},
        ),
        header: SwiperHeader(list: List.from(SpaceXPhotos.capsules)..shuffle()),
        children: <Widget>[
          SliverSafeArea(
            top: false,
            sliver: SliverToBoxAdapter(
              child: RowLayout.body(children: <Widget>[
                RowItem.text(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.vehicle.model',
                  ),
                  capsule.type,
                ),
                RowItem.text(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.vehicle.status',
                  ),
                  capsule.getStatus,
                ),
                RowItem.text(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.vehicle.first_launched',
                  ),
                  capsule.getFirstLaunched(context),
                ),
                RowItem.text(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.vehicle.launches',
                  ),
                  capsule.getLaunches,
                ),
                RowItem.text(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.vehicle.splashings',
                  ),
                  capsule.getSplashings,
                ),
                Separator.divider(),
                if (capsule.hasMissions) ...[
                  for (final launch in capsule.launches)
                    RowTap(
                      FlutterI18n.translate(
                        context,
                        'spacex.dialog.vehicle.mission',
                        translationParams: {
                          'number': launch.flightNumber.toString()
                        },
                      ),
                      launch.name,
                      onTap: () => Navigator.pushNamed(
                        context,
                        LaunchPage.route,
                        arguments: {'id': launch.id},
                      ),
                    ),
                  Separator.divider()
                ],
                ExpandText(capsule.getDetails(context))
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
