import 'package:cherry_components/cherry_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';

import '../../repositories/index.dart';
import '../../util/photos.dart';
import '../widgets/index.dart';

/// This view displays information about a specific core,
/// used in a mission.
class CoreDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CoreRepository>(
      builder: (context, model, child) => Scaffold(
        body: SliverPage<CoreRepository>.slide(
          title: FlutterI18n.translate(
            context,
            'spacex.dialog.vehicle.title_core',
            translationParams: {'serial': model.id},
          ),
          slides: List.from(SpaceXPhotos.cores)..shuffle(),
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
    return Consumer<CoreRepository>(
      builder: (context, model, child) => RowLayout.body(children: <Widget>[
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.dialog.vehicle.model',
          ),
          model.core.getBlock(context),
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.dialog.vehicle.status',
          ),
          model.core.getStatus,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.dialog.vehicle.first_launched',
          ),
          model.core.getFirstLaunched(context),
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.dialog.vehicle.launches',
          ),
          model.core.getLaunches,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.dialog.vehicle.landings_rtls',
          ),
          model.core.getRtlsLandings,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.dialog.vehicle.landings_asds',
          ),
          model.core.getAsdsLandings,
        ),
        Separator.divider(),
        if (model.core.hasMissions) ...[
          for (final mission in model.core.missions)
            RowText(
              FlutterI18n.translate(
                context,
                'spacex.dialog.vehicle.mission',
                translationParams: {'number': mission.id.toString()},
              ),
              mission.name,
            ),
          Separator.divider()
        ],
        TextExpand(model.core.getDetails(context))
      ]),
    );
  }
}
