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
  @override
  Widget build(BuildContext context) {
    return Consumer<CapsuleRepository>(
      builder: (context, model, child) => Scaffold(
        body: SliverPage<CapsuleRepository>.slide(
          title: FlutterI18n.translate(
            context,
            'spacex.dialog.vehicle.title_capsule',
            translationParams: {'serial': model.id},
          ),
          slides: List.from(SpaceXPhotos.capsules)..shuffle(),
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
    return Consumer<CapsuleRepository>(
      builder: (context, model, child) => RowLayout.body(children: <Widget>[
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.dialog.vehicle.model',
          ),
          model.capsule.name,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.dialog.vehicle.status',
          ),
          model.capsule.getStatus,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.dialog.vehicle.first_launched',
          ),
          model.capsule.getFirstLaunched(context),
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.dialog.vehicle.launches',
          ),
          model.capsule.getLaunches,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.dialog.vehicle.splashings',
          ),
          model.capsule.getSplashings,
        ),
        Separator.divider(),
        if (model.capsule.hasMissions) ...[
          for (final mission in model.capsule.missions)
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
        TextExpand(model.capsule.getDetails(context))
      ]),
    );
  }
}
