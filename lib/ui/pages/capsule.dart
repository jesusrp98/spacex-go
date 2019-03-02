import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/details_capsule.dart';
import '../../models/mission_item.dart';
import '../../widgets/expand_widget.dart';
import '../../widgets/header_swiper.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/row_item.dart';
import '../../widgets/separator.dart';
import '../../widgets/sliver_bar.dart';

/// CAPSULE PAGE VIEW
/// This view displays information about a specific capsule,
/// used in a NASA mission.
class CapsulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CapsuleModel>(
      builder: (context, child, model) => Scaffold(
            body: CustomScrollView(slivers: <Widget>[
              SliverBar(
                title: Text(FlutterI18n.translate(
                  context,
                  'spacex.dialog.vehicle.title_capsule',
                  {'serial': model.id},
                )),
                header: model.isLoading
                    ? LoadingIndicator()
                    : SwiperHeader(list: model.photos),
              ),
              model.isLoading
                  ? SliverFillRemaining(child: LoadingIndicator())
                  : SliverToBoxAdapter(child: _buildBody())
            ]),
          ),
    );
  }

  Widget _buildBody() {
    return ScopedModelDescendant<CapsuleModel>(
      builder: (context, child, model) => Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: <Widget>[
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.vehicle.model',
                ),
                model.capsule.name,
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.vehicle.status',
                ),
                model.capsule.getStatus,
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.vehicle.first_launched',
                ),
                model.capsule.getFirstLaunched(context),
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.vehicle.launches',
                ),
                model.capsule.getLaunches,
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.vehicle.splashings',
                ),
                model.capsule.getSplashings,
              ),
              Separator.divider(),
              model.capsule.hasMissions
                  ? Column(children: <Widget>[
                      Column(
                        children: model.capsule.missions
                            .map((mission) => _getMission(
                                  context,
                                  model.capsule.missions,
                                  mission,
                                ))
                            .toList(),
                      ),
                      Separator.divider(),
                    ])
                  : Separator.none(),
              TextExpand(
                text: model.capsule.getDetails(context),
                maxLength: 8,
                style: TextStyle(
                  color: Theme.of(context).textTheme.caption.color,
                  fontSize: 15,
                ),
              )
            ]),
          ),
    );
  }

  Column _getMission(BuildContext context, List missions, MissionItem mission) {
    return Column(children: <Widget>[
      RowItem.textRow(
        context,
        FlutterI18n.translate(
          context,
          'spacex.dialog.vehicle.mission',
          {'number': mission.id.toString()},
        ),
        mission.name,
      ),
      mission != missions.last ? Separator.spacer() : Separator.none(),
    ]);
  }
}
