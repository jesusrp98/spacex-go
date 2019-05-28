import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:row_collection/row_collection.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/details_capsule.dart';
import '../../widgets/expand_widget.dart';
import '../../widgets/row_item.dart';
import '../../widgets/scroll_page.dart';

/// CAPSULE PAGE VIEW
/// This view displays information about a specific capsule,
/// used in a NASA mission.
class CapsulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CapsuleModel>(
      builder: (context, child, model) => Scaffold(
            body: ScrollPage<CapsuleModel>.photos(
              title: FlutterI18n.translate(
                context,
                'spacex.dialog.vehicle.title_capsule',
                {'serial': model.id},
              ),
              photos: model.photos,
              children: <Widget>[
                SliverToBoxAdapter(child: _buildBody()),
              ],
            ),
          ),
    );
  }

  Widget _buildBody() {
    return ScopedModelDescendant<CapsuleModel>(
      builder: (context, child, model) => RowLayout.body(children: <Widget>[
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
              for (var mission in model.capsule.missions)
                RowText(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.vehicle.mission',
                    {'number': mission.id.toString()},
                  ),
                  mission.name,
                ),
              Separator.divider()
            ],
            TextExpand(text: model.capsule.getDetails(context), maxLength: 8)
          ]),
    );
  }
}
