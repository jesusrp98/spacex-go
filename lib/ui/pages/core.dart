import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';
import 'package:row_item/row_item.dart';

import '../../cubits/index.dart';
import '../../util/photos.dart';
import '../widgets/index.dart';
import 'index.dart';

/// This view displays information about a specific core,
/// used in a mission.
class CorePage extends StatelessWidget {
  final String launchId;
  final String coreId;

  const CorePage({
    Key key,
    this.launchId,
    this.coreId,
  }) : super(key: key);

  static const route = '/core';

  @override
  Widget build(BuildContext context) {
    final core = context
        .watch<LaunchesCubit>()
        .getLaunch(launchId)
        .rocket
        .getCore(coreId);

    return Scaffold(
      body: SliverPage(
        title: FlutterI18n.translate(
          context,
          'spacex.dialog.vehicle.title_core',
          translationParams: {'serial': core.serial},
        ),
        header: SwiperHeader(list: List.from(SpaceXPhotos.cores)..shuffle()),
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
                  core.getBlock(context),
                ),
                RowItem.text(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.vehicle.status',
                  ),
                  core.getStatus,
                ),
                RowItem.text(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.vehicle.first_launched',
                  ),
                  core.getFirstLaunched(context),
                ),
                RowItem.text(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.vehicle.launches',
                  ),
                  core.getLaunches,
                ),
                RowItem.text(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.vehicle.landings_rtls',
                  ),
                  core.getRtlsLandings,
                ),
                RowItem.text(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.vehicle.landings_asds',
                  ),
                  core.getAsdsLandings,
                ),
                Separator.divider(),
                if (core.hasMissions) ...[
                  for (final mission in core.launches)
                    RowTap(
                      FlutterI18n.translate(
                        context,
                        'spacex.dialog.vehicle.mission',
                        translationParams: {
                          'number': mission.flightNumber.toString()
                        },
                      ),
                      mission.name,
                      onTap: () => Navigator.pushNamed(
                        context,
                        LaunchPage.route,
                        arguments: {'id': mission.id},
                      ),
                    ),
                  Separator.divider()
                ],
                ExpandText(core.getDetails(context))
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
