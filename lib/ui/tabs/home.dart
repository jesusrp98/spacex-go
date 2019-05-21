import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:row_collection/row_collection.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/details_capsule.dart';
import '../../models/details_core.dart';
import '../../models/launchpad.dart';
import '../../models/spacex_home.dart';
import '../../widgets/dialog_round.dart';
import '../../widgets/list_cell.dart';
import '../../widgets/scroll_page.dart';
import '../pages/capsule.dart';
import '../pages/core.dart';
import '../pages/launch.dart';
import '../pages/launchpad.dart';

/// SPACEX HOME TAB
/// This tab holds main information about the next launch.
/// It has a countdown widget.
class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SpacexHomeModel>(
      builder: (context, child, model) => Scaffold(
            body: ScrollPage<SpacexHomeModel>.tab(
              context: context,
              photos: model.photos,
              title: FlutterI18n.translate(context, 'spacex.home.title'),
              children: <Widget>[
                SliverToBoxAdapter(child: _buildBody()),
              ],
            ),
          ),
    );
  }

  Widget _buildBody() {
    return ScopedModelDescendant<SpacexHomeModel>(
      builder: (context, child, model) => Column(children: <Widget>[
            if (!model.launch.tentativeTime) ...<Widget>[
              Padding(
                padding: EdgeInsets.all(12),
                child: LaunchCountdown(model.launch),
              ),
              Separator.divider(),
            ],
            ListCell.icon(
              icon: Icons.public,
              trailing: Icon(Icons.chevron_right),
              title: model.vehicle(context),
              subtitle: model.payload(context),
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LaunchPage(model.launch),
                    ),
                  ),
            ),
            Separator.divider(indent: 72),
            ListCell.icon(
              icon: Icons.event,
              trailing: Icon(Icons.chevron_right),
              title: FlutterI18n.translate(
                context,
                'spacex.home.tab.date.title',
              ),
              subtitle: model.launchDate(context),
              onTap: () => Add2Calendar.addEvent2Cal(
                    Event(
                      title: model.launch.name,
                      description: model.launch.details ??
                          FlutterI18n.translate(
                            context,
                            'spacex.launch.page.no_description',
                          ),
                      location: model.launch.launchpadName,
                      startDate: model.launch.launchDate,
                      endDate: model.launch.launchDate.add(
                        Duration(minutes: 30),
                      ),
                    ),
                  ),
            ),
            Separator.divider(indent: 72),
            ListCell.icon(
              icon: Icons.location_on,
              trailing: Icon(Icons.chevron_right),
              title: FlutterI18n.translate(
                context,
                'spacex.home.tab.launchpad.title',
              ),
              subtitle: model.launchpad(context),
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScopedModel<LaunchpadModel>(
                            model: LaunchpadModel(
                              model.launch.launchpadId,
                              model.launch.launchpadName,
                            )..loadData(),
                            child: LaunchpadPage(),
                          ),
                      fullscreenDialog: true,
                    ),
                  ),
            ),
            Separator.divider(indent: 72),
            ListCell.icon(
              icon: Icons.timer,
              title: FlutterI18n.translate(
                context,
                'spacex.home.tab.static_fire.title',
              ),
              subtitle: model.staticFire(context),
            ),
            Separator.divider(indent: 72),
            model.launch.rocket.hasFairing
                ? ListCell.icon(
                    icon: Icons.directions_boat,
                    title: FlutterI18n.translate(
                      context,
                      'spacex.home.tab.fairings.title',
                    ),
                    subtitle: model.fairings(context),
                  )
                : AbsorbPointer(
                    absorbing: model.launch.rocket.secondStage
                            .getPayload(0)
                            .capsuleSerial ==
                        null,
                    child: ListCell.icon(
                      icon: Icons.shopping_basket,
                      trailing: Icon(
                        Icons.chevron_right,
                        color: model.launch.rocket.secondStage
                                    .getPayload(0)
                                    .capsuleSerial ==
                                null
                            ? Theme.of(context).disabledColor
                            : Theme.of(context).iconTheme.color,
                      ),
                      title: FlutterI18n.translate(
                        context,
                        'spacex.home.tab.capsule.title',
                      ),
                      subtitle: model.capsule(context),
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScopedModel<CapsuleModel>(
                                    model: CapsuleModel(
                                      model.launch.rocket.secondStage
                                          .getPayload(0)
                                          .capsuleSerial,
                                    )..loadData(),
                                    child: CapsulePage(),
                                  ),
                              fullscreenDialog: true,
                            ),
                          ),
                    ),
                  ),
            Separator.divider(indent: 72),
            AbsorbPointer(
              absorbing: model.launch.rocket.isFirstStageNull,
              child: ListCell.icon(
                icon: Icons.autorenew,
                trailing: Icon(
                  Icons.chevron_right,
                  color: model.launch.rocket.isFirstStageNull
                      ? Theme.of(context).disabledColor
                      : Theme.of(context).iconTheme.color,
                ),
                title: FlutterI18n.translate(
                  context,
                  'spacex.home.tab.first_stage.title',
                ),
                subtitle: model.firstStage(context),
                onTap: () => model.launch.rocket.isHeavy
                    ? showHeavyDialog(context, model)
                    : openCorePage(
                        context,
                        model.launch.rocket.getSingleCore.id,
                      ),
              ),
            ),
            Separator.divider(indent: 72)
          ]),
    );
  }

  showHeavyDialog(BuildContext context, SpacexHomeModel model) {
    showDialog(
      context: context,
      builder: (context) => RoundDialog(
            title: FlutterI18n.translate(
              context,
              'spacex.home.tab.first_stage.heavy_dialog.title',
            ),
            children: model.launch.rocket.firstStage
                .map((core) => AbsorbPointer(
                      absorbing: core.id == null,
                      child: ListCell(
                        trailing: Icon(
                          Icons.chevron_right,
                          color: core.id == null
                              ? Theme.of(context).textTheme.caption.color
                              : Theme.of(context).textTheme.title.color,
                        ),
                        title: core.id != null
                            ? FlutterI18n.translate(
                                context,
                                'spacex.dialog.vehicle.title_core',
                                {'serial': core.id},
                              )
                            : FlutterI18n.translate(
                                context,
                                'spacex.home.tab.first_stage.heavy_dialog.core_null_title',
                              ),
                        subtitle: model.core(context, core),
                        onTap: () => openCorePage(
                              context,
                              core.id,
                            ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 24,
                        ),
                      ),
                    ))
                .toList(),
          ),
    );
  }

  openCorePage(BuildContext context, String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScopedModel<CoreModel>(
              model: CoreModel(id)..loadData(),
              child: CoreDialog(),
            ),
        fullscreenDialog: true,
      ),
    );
  }
}
