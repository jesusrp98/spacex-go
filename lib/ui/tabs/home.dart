import 'dart:async';

import 'package:add_2_calendar/add_2_calendar.dart';
import '../../widgets/dialog_round.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/details_capsule.dart';
import '../../models/details_core.dart';
import '../../models/launchpad.dart';
import '../../models/spacex_home.dart';
import '../../util/menu.dart';
import '../../widgets/header_swiper.dart';
import '../../widgets/list_cell.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/separator.dart';
import '../../widgets/sliver_bar.dart';
import '../pages/capsule.dart';
import '../pages/core.dart';
import '../pages/launch.dart';
import '../pages/launchpad.dart';

/// SPACEX HOME TAB
/// This tab holds main information about the next launch.
/// It has a countdown widget.
class HomeTab extends StatelessWidget {
  Future<Null> _onRefresh(SpacexHomeModel model) {
    Completer<Null> completer = Completer<Null>();
    model.refresh().then((_) => completer.complete());
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SpacexHomeModel>(
      builder: (context, child, model) => Scaffold(
            body: RefreshIndicator(
              onRefresh: () => _onRefresh(model),
              child: CustomScrollView(
                  key: PageStorageKey('spacex_home'),
                  slivers: <Widget>[
                    SliverBar(
                      title: Text(FlutterI18n.translate(
                        context,
                        'spacex.home.title',
                      )),
                      header: model.isLoading
                          ? LoadingIndicator()
                          : SwiperHeader(list: model.photos),
                      actions: <Widget>[
                        PopupMenuButton<String>(
                          itemBuilder: (_) => Menu.home.keys
                              .map((string) => PopupMenuItem(
                                    value: string,
                                    child: Text(
                                      FlutterI18n.translate(context, string),
                                    ),
                                  ))
                              .toList(),
                          onSelected: (string) => Navigator.pushNamed(
                                context,
                                Menu.home[string],
                              ),
                        ),
                      ],
                    ),
                    model.isLoading
                        ? SliverFillRemaining(child: LoadingIndicator())
                        : SliverToBoxAdapter(child: _buildBody())
                  ]),
            ),
          ),
    );
  }

  Widget _buildBody() {
    return ScopedModelDescendant<SpacexHomeModel>(
      builder: (context, child, model) => Column(children: <Widget>[
            model.launch.tentativeTime
                ? Separator.none()
                : Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: LaunchCountdown(model.launch),
                    ),
                    Separator.divider(height: 0),
                  ]),
            ListCell(
              leading: const Icon(Icons.public, size: 40),
              title: model.vehicle(context),
              subtitle: model.payload(context),
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LaunchPage(model.launch)),
                  ),
            ),
            Separator.divider(height: 0, indent: 72),
            ListCell(
              leading: const Icon(Icons.event, size: 40),
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
            Separator.divider(height: 0, indent: 72),
            ListCell(
              leading: const Icon(Icons.location_on, size: 40),
              title: FlutterI18n.translate(
                context,
                'spacex.home.tab.launchpad.title',
              ),
              subtitle: model.launchpad(context),
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ScopedModel<LaunchpadModel>(
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
            Separator.divider(height: 0, indent: 72),
            ListCell(
              leading: const Icon(Icons.timer, size: 40),
              title: FlutterI18n.translate(
                context,
                'spacex.home.tab.static_fire.title',
              ),
              subtitle: model.staticFire(context),
            ),
            Separator.divider(height: 0, indent: 72),
            model.launch.rocket.hasFairing
                ? ListCell(
                    leading: const Icon(Icons.directions_boat, size: 40),
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
                    child: ListCell(
                      leading: const Icon(Icons.shopping_basket, size: 40),
                      title: FlutterI18n.translate(
                        context,
                        'spacex.home.tab.capsule.title',
                      ),
                      subtitle: model.capsule(context),
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ScopedModel<CapsuleModel>(
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
            Separator.divider(height: 0, indent: 72),
            AbsorbPointer(
              absorbing: model.launch.rocket.isFirstStageNull,
              child: ListCell(
                leading: const Icon(Icons.autorenew, size: 40),
                title: FlutterI18n.translate(
                  context,
                  'spacex.home.tab.first_stage.title',
                ),
                subtitle: model.firstStage(context),
                onTap: () => model.launch.rocket.isHeavy
                    ? showDialog(
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
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 24,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                      )
                    : openCorePage(
                        context,
                        model.launch.rocket.getSingleCore.id,
                      ),
              ),
            )
          ]),
    );
  }

  openCorePage(BuildContext context, String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ScopedModel<CoreModel>(
              model: CoreModel(id)..loadData(),
              child: CoreDialog(),
            ),
        fullscreenDialog: true,
      ),
    );
  }
}
