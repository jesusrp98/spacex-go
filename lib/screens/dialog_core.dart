import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/details_core.dart';
import '../models/mission_item.dart';
import '../widgets/cache_image.dart';
import '../widgets/row_item.dart';
import '../widgets/separator.dart';

/// CORE DIALOG VIEW
/// This view displays information about a specific core,
/// used in a mission.
class CoreDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CoreModel>(
      builder: (context, child, model) => Scaffold(
            body: CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.3,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(FlutterI18n.translate(
                    context,
                    'spacex.dialog.vehicle.title_core',
                    {'serial': model.id},
                  )),
                  background: model.isLoading
                      ? CircularProgressIndicator()
                      : Swiper(
                          itemCount: model.getPhotosCount,
                          itemBuilder: (_, index) => CacheImage(
                                model.getPhoto(index),
                              ),
                          autoplay: true,
                          autoplayDelay: 6000,
                          duration: 750,
                          onTap: (index) async =>
                              await FlutterWebBrowser.openWebPage(
                                url: model.getPhoto(index),
                                androidToolbarColor:
                                    Theme.of(context).primaryColor,
                              ),
                        ),
                ),
              ),
              model.isLoading
                  ? SliverFillRemaining(
                      child: CircularProgressIndicator(),
                    )
                  : SliverToBoxAdapter(child: _buildBody())
            ]),
          ),
    );
  }

  Widget _buildBody() {
    return ScopedModelDescendant<CoreModel>(
      builder: (context, child, model) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: <Widget>[
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.vehicle.model',
                ),
                model.core.getBlock(context),
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.vehicle.status',
                ),
                model.core.getStatus,
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.vehicle.first_launched',
                ),
                model.core.getFirstLaunched(context),
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.vehicle.launches',
                ),
                model.core.getLaunches,
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.vehicle.landings_rtls',
                ),
                model.core.getRtlsLandings,
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.vehicle.landings_asds',
                ),
                model.core.getAsdsLandings,
              ),
              Separator.divider(),
              model.core.hasMissions
                  ? Column(children: <Widget>[
                      Column(
                        children: model.core.missions
                            .map((mission) => _getMission(
                                  context,
                                  model.core.missions,
                                  mission,
                                ))
                            .toList(),
                      ),
                      Separator.divider(),
                    ])
                  : Separator.none(),
              Text(
                model.core.getDetails(context),
                textAlign: TextAlign.justify,
                style: Theme.of(context)
                    .textTheme
                    .subhead
                    .copyWith(color: Theme.of(context).textTheme.caption.color),
              ),
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
