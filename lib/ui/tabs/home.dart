import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cherry_components/cherry_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';

import '../../models/index.dart';
import '../../repositories/index.dart';
import '../../util/menu.dart';
import '../../util/photos.dart';
import '../pages/index.dart';
import '../widgets/index.dart';

/// This tab holds main information about the next launch.
/// It has a countdown widget.
class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  ScrollController _controller;
  double _offset = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(() => setState(() => _offset = _controller.offset));
  }

  Widget _headerDetails(BuildContext context, Launch launch) {
    final _sliverHeight =
        MediaQuery.of(context).size.height * SliverBar.heightRatio;

    // When user scrolls 10% height of the SliverAppBar,
    // header countdown widget will dissapears.
    return launch != null &&
            MediaQuery.of(context).orientation != Orientation.landscape
        ? AnimatedOpacity(
            opacity: _offset > _sliverHeight / 10 ? 0.0 : 1.0,
            duration: Duration(milliseconds: 350),
            child: launch.launchDate.isAfter(DateTime.now()) &&
                    !launch.isDateTooTentative
                ? LaunchCountdown(launch.launchDate)
                : launch.hasVideo && !launch.isDateTooTentative
                    ? InkWell(
                        onTap: () => FlutterWebBrowser.openWebPage(
                          url: launch.getVideo,
                          androidToolbarColor: Theme.of(context).primaryColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 50,
                              ),
                              Separator.smallSpacer(),
                              Text(
                                FlutterI18n.translate(
                                  context,
                                  'spacex.home.tab.live_mission',
                                ),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.robotoMono(
                                  fontSize: 24,
                                  color: Colors.white,
                                  shadows: <Shadow>[
                                    Shadow(
                                      blurRadius: 4,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Separator.none(),
          )
        : Separator.none();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LaunchesRepository>(
      builder: (context, model, child) =>
          ReloadableSliverPage<LaunchesRepository>.display(
        controller: _controller,
        title: FlutterI18n.translate(context, 'spacex.home.title'),
        opacity: model.upcomingLaunch?.isDateTooTentative == true &&
                MediaQuery.of(context).orientation != Orientation.landscape
            ? 1.0
            : 0.64,
        counter: _headerDetails(context, model.upcomingLaunch),
        slides: List.from(SpaceXPhotos.home)..shuffle(),
        popupMenu: Menu.home,
        body: <Widget>[
          SliverToBoxAdapter(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Consumer<LaunchesRepository>(
      builder: (context, model, child) => Column(children: <Widget>[
        ListCell.icon(
          icon: Icons.public,
          title: FlutterI18n.translate(
            context,
            'spacex.home.tab.mission.title',
            translationParams: {'rocket': model.upcomingLaunch.rocket.name},
          ),
          subtitle: nextPayload,
          onTap: () => Navigator.pushNamed(
            context,
            LaunchPage.route,
            arguments: {'id': model.upcomingLaunch.id},
          ),
        ),
        Separator.divider(indent: 72),
        ListCell.icon(
          icon: Icons.event,
          title: FlutterI18n.translate(
            context,
            'spacex.home.tab.date.title',
          ),
          subtitle: model.upcomingLaunch.tentativeTime
              ? FlutterI18n.translate(
                  context,
                  'spacex.home.tab.date.body_upcoming',
                  translationParams: {
                    'date': model.upcomingLaunch.getTentativeDate
                  },
                )
              : FlutterI18n.translate(
                  context,
                  'spacex.home.tab.date.body',
                  translationParams: {
                    'date': model.upcomingLaunch.getTentativeDate,
                    'time': model.upcomingLaunch.getShortTentativeTime
                  },
                ),
          onTap: !model.upcomingLaunch.tentativeTime
              ? () async {
                  await Add2Calendar.addEvent2Cal(Event(
                    title: model.upcomingLaunch.name,
                    description: model.upcomingLaunch.details ??
                        FlutterI18n.translate(
                          context,
                          'spacex.launch.page.no_description',
                        ),
                    location: model.upcomingLaunch.launchpad.name ??
                        FlutterI18n.translate(
                          context,
                          'spacex.other.unknown',
                        ),
                    startDate: model.upcomingLaunch.launchDate,
                    endDate: model.upcomingLaunch.launchDate.add(
                      Duration(minutes: 30),
                    ),
                  ));
                }
              : null,
        ),
        Separator.divider(indent: 72),
        ListCell.icon(
          icon: Icons.location_on,
          title: FlutterI18n.translate(
            context,
            'spacex.home.tab.launchpad.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'spacex.home.tab.launchpad.body',
            translationParams: {
              'launchpad': model.upcomingLaunch.launchpad.name
            },
          ),
          onTap: model.upcomingLaunch.launchpad != null
              ? () => Navigator.pushNamed(
                    context,
                    LaunchpadPage.route,
                    arguments: {'launchId': model.upcomingLaunch.id},
                  )
              : null,
        ),
        Separator.divider(indent: 72),
        ListCell.icon(
          icon: Icons.timer,
          title: FlutterI18n.translate(
            context,
            'spacex.home.tab.static_fire.title',
          ),
          subtitle: model.upcomingLaunch.staticFireDate == null
              ? FlutterI18n.translate(
                  context,
                  'spacex.home.tab.static_fire.body_unknown',
                )
              : FlutterI18n.translate(
                  context,
                  model.upcomingLaunch.staticFireDate.isBefore(DateTime.now())
                      ? 'spacex.home.tab.static_fire.body_done'
                      : 'spacex.home.tab.static_fire.body',
                  translationParams: {
                    'date': model.upcomingLaunch.getStaticFireDate(context)
                  },
                ),
        ),
        Separator.divider(indent: 72),
        if (model.upcomingLaunch.rocket.hasFairings)
          ListCell.icon(
            icon: Icons.directions_boat,
            title: FlutterI18n.translate(
              context,
              'spacex.home.tab.fairings.title',
            ),
            subtitle: nextFairings,
          )
        else
          AbsorbPointer(
            absorbing: !model.upcomingLaunch.rocket.hasCapsule,
            child: ListCell.svg(
              context: context,
              image: 'assets/icons/capsule.svg',
              title: FlutterI18n.translate(
                context,
                'spacex.home.tab.capsule.title',
              ),
              subtitle: nextCapsule,
              onTap: model.upcomingLaunch.rocket.hasCapsule
                  ? () => Navigator.pushNamed(
                        context,
                        CapsulePage.route,
                        arguments: {
                          'launchId': model.upcomingLaunch.id,
                        },
                      )
                  : null,
            ),
          ),
        Separator.divider(indent: 72),
        AbsorbPointer(
          absorbing: model.upcomingLaunch.rocket.isFirstStageNull,
          child: ListCell.svg(
            context: context,
            image: 'assets/icons/fins.svg',
            title: FlutterI18n.translate(
              context,
              'spacex.home.tab.first_stage.title',
            ),
            subtitle: model.upcomingLaunch.rocket.isHeavy
                ? FlutterI18n.translate(
                    context,
                    model.upcomingLaunch.rocket.isFirstStageNull
                        ? 'spacex.home.tab.first_stage.body_null'
                        : 'spacex.home.tab.first_stage.heavy_dialog.body',
                  )
                : nextCore(model.upcomingLaunch.rocket.getSingleCore),
            onTap: !model.upcomingLaunch.rocket.isFirstStageNull
                ? () => model.upcomingLaunch.rocket.isHeavy
                    ? showHeavyDialog(context)
                    : openCorePage(
                        context: context,
                        launchId: model.upcomingLaunch.id,
                        coreId: model.upcomingLaunch.rocket.getSingleCore.id,
                      )
                : null,
          ),
        ),
        Separator.divider(indent: 72),
        ListCell.icon(
          icon: Icons.center_focus_weak,
          title: FlutterI18n.translate(
            context,
            'spacex.home.tab.landing.title',
          ),
          subtitle: nextLanding,
          onTap: model.upcomingLaunch.rocket.getSingleCore.landpad != null
              ? () => Navigator.pushNamed(
                    context,
                    LandpadPage.route,
                    arguments: {
                      'launchId': model.upcomingLaunch.id,
                      'coreId': model.upcomingLaunch.rocket.getSingleCore.id,
                    },
                  )
              : null,
        ),
        Separator.divider(indent: 72)
      ]),
    );
  }

  void showHeavyDialog(BuildContext context) {
    showBottomRoundDialog(
      context: context,
      title: FlutterI18n.translate(
        context,
        'spacex.home.tab.first_stage.heavy_dialog.title',
      ),
      children: [
        for (final core
            in context.read<LaunchesRepository>().upcomingLaunch.rocket.cores)
          AbsorbPointer(
            absorbing: core.id == null,
            child: ListCell(
              title: core.id != null
                  ? FlutterI18n.translate(
                      context,
                      'spacex.dialog.vehicle.title_core',
                      translationParams: {'serial': core.serial},
                    )
                  : FlutterI18n.translate(
                      context,
                      'spacex.home.tab.first_stage.heavy_dialog.core_null_title',
                    ),
              subtitle: nextCore(core),
              onTap: () => openCorePage(
                context: context,
                launchId: context.read<LaunchesRepository>().upcomingLaunch.id,
                coreId: core.id,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              dense: true,
            ),
          )
      ],
    );
  }

  void openCorePage({BuildContext context, String launchId, String coreId}) {
    Navigator.pushNamed(
      context,
      CorePage.route,
      arguments: {
        'launchId': launchId,
        'coreId': coreId,
      },
    );
  }

  String get nextLanding {
    final core =
        context.read<LaunchesRepository>().upcomingLaunch.rocket.getSingleCore;

    if (core.landingAttempt == null) {
      return FlutterI18n.translate(
        context,
        'spacex.home.tab.landing.body_null',
      );
    } else if (!core.landingAttempt) {
      return FlutterI18n.translate(
        context,
        'spacex.home.tab.landing.body_expended',
      );
    } else if (core.landpad == null && core.landingType != null) {
      return FlutterI18n.translate(
        context,
        'spacex.home.tab.landing.body_type',
        translationParams: {'type': core.landingType},
      );
    } else {
      return FlutterI18n.translate(
        context,
        'spacex.home.tab.landing.body',
        translationParams: {'zone': core.landpad.name},
      );
    }
  }

  String get nextPayload {
    const maxPayload = 3;

    final StringBuffer buffer = StringBuffer();
    final payloadSize = context
        .read<LaunchesRepository>()
        .upcomingLaunch
        .rocket
        .payloads
        .length;

    final payloads = context
        .read<LaunchesRepository>()
        .upcomingLaunch
        .rocket
        .payloads
        .sublist(0, payloadSize > maxPayload ? maxPayload : payloadSize);

    for (int i = 0; i < payloads.length; ++i) {
      buffer.write(
        FlutterI18n.translate(
              context,
              'spacex.home.tab.mission.body_payload',
              translationParams: {
                'name': payloads[i].name,
                'orbit': payloads[i].orbit
              },
            ) +
            (i + 1 == payloads.length ? '' : ', '),
      );
    }

    return FlutterI18n.translate(
      context,
      'spacex.home.tab.mission.body',
      translationParams: {'payloads': buffer.toString()},
    );
  }

  String get nextFairings {
    final fairing =
        context.read<LaunchesRepository>().upcomingLaunch.rocket.fairings;

    return fairing.reused == null && fairing.recoveryAttempt == null
        ? FlutterI18n.translate(
            context,
            'spacex.home.tab.fairings.body_null',
          )
        : fairing.reused != null && fairing.recoveryAttempt == null
            ? FlutterI18n.translate(
                context,
                fairing.reused == true
                    ? 'spacex.home.tab.fairings.body_reused'
                    : 'spacex.home.tab.fairings.body_new',
              )
            : FlutterI18n.translate(
                context,
                'spacex.home.tab.fairings.body',
                translationParams: {
                  'reused': FlutterI18n.translate(
                    context,
                    fairing.reused == true
                        ? 'spacex.home.tab.fairings.body_reused'
                        : 'spacex.home.tab.fairings.body_new',
                  ),
                  'catched': FlutterI18n.translate(
                    context,
                    fairing.recoveryAttempt == true
                        ? 'spacex.home.tab.fairings.body_catching'
                        : 'spacex.home.tab.fairings.body_dispensed',
                  )
                },
              );
  }

  String nextCore(Core core) {
    final isSideCore = context
        .read<LaunchesRepository>()
        .upcomingLaunch
        .rocket
        .isSideCore(core);

    return core.id == null || core.reused == null
        ? FlutterI18n.translate(
            context,
            'spacex.home.tab.first_stage.body_null',
          )
        : FlutterI18n.translate(
            context,
            'spacex.home.tab.first_stage.body',
            translationParams: {
              'booster': FlutterI18n.translate(
                context,
                isSideCore
                    ? 'spacex.home.tab.first_stage.side_core'
                    : 'spacex.home.tab.first_stage.booster',
              ),
              'reused': FlutterI18n.translate(
                context,
                core.reused
                    ? 'spacex.home.tab.first_stage.body_reused'
                    : 'spacex.home.tab.first_stage.body_new',
              ),
            },
          );
  }

  String get nextCapsule {
    final capsule = context
        .read<LaunchesRepository>()
        .upcomingLaunch
        .rocket
        .getSinglePayload;

    return capsule.capsule.serial == null
        ? FlutterI18n.translate(context, 'spacex.home.tab.capsule.body_null')
        : FlutterI18n.translate(
            context,
            'spacex.home.tab.capsule.body',
            translationParams: {
              'reused': capsule.reused
                  ? FlutterI18n.translate(
                      context,
                      'spacex.home.tab.capsule.body_reused',
                    )
                  : FlutterI18n.translate(
                      context,
                      'spacex.home.tab.capsule.body_new',
                    )
            },
          );
  }
}
