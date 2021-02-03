import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cherry_components/cherry_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:row_collection/row_collection.dart';

import '../../cubits/index.dart';
import '../../models/index.dart';
import '../../util/index.dart';
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

  @override
  Widget build(BuildContext context) {
    return RequestSliverPage<LaunchesCubit, List<List<Launch>>>(
      controller: _controller,
      title: FlutterI18n.translate(context, 'spacex.home.title'),
      popupMenu: Menu.home,
      headerBuilder: (context, state, value) => _HeaderView(
        launch: LaunchUtils.getUpcomingLaunch(value),
        offset: _offset,
      ),
      childrenBuilder: (context, state, value) => <Widget>[
        SliverToBoxAdapter(
          child: _HomeView(
            LaunchUtils.getUpcomingLaunch(value),
          ),
        ),
      ],
    );
  }
}

class _HeaderView extends StatelessWidget {
  final Launch launch;
  final double offset;

  const _HeaderView({
    Key key,
    this.launch,
    this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _sliverHeight =
        MediaQuery.of(context).size.height * SliverBar.heightRatio;
    final _isNotLandscape =
        MediaQuery.of(context).orientation != Orientation.landscape;

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Opacity(
          opacity: launch.isDateTooTentative && _isNotLandscape ? 1.0 : 0.64,
          child: SwiperHeader(
            list: List.from(SpaceXPhotos.home)..shuffle(),
          ),
        ),
        if (_isNotLandscape)
          AnimatedOpacity(
            opacity: offset > _sliverHeight / 10 ? 0.0 : 1.0,
            duration: Duration(milliseconds: 350),
            child: launch.localLaunchDate.isAfter(DateTime.now()) &&
                    !launch.isDateTooTentative
                ? LaunchCountdown(launch.localLaunchDate)
                : launch.hasVideo && !launch.isDateTooTentative
                    ? InkWell(
                        onTap: () => openUrl(launch.getVideo),
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
          ),
      ],
    );
  }
}

class _HomeView extends StatelessWidget {
  final Launch launch;

  const _HomeView(this.launch, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ListCell.icon(
        icon: Icons.public,
        title: FlutterI18n.translate(
          context,
          'spacex.home.tab.mission.title',
          translationParams: {'rocket': launch.rocket.name},
        ),
        subtitle: payloadSubtitle(context, launch.rocket.payloads),
        onTap: () => Navigator.pushNamed(
          context,
          LaunchPage.route,
          arguments: {'id': launch.id},
        ),
      ),
      Separator.divider(indent: 72),
      ListCell.icon(
        icon: Icons.event,
        title: FlutterI18n.translate(
          context,
          'spacex.home.tab.date.title',
        ),
        subtitle: launch.tentativeTime
            ? FlutterI18n.translate(
                context,
                'spacex.home.tab.date.body_upcoming',
                translationParams: {'date': launch.getTentativeDate},
              )
            : FlutterI18n.translate(
                context,
                'spacex.home.tab.date.body',
                translationParams: {
                  'date': launch.getTentativeDate,
                  'time': launch.getShortTentativeTime
                },
              ),
        onTap: !launch.tentativeTime
            ? () async {
                await Add2Calendar.addEvent2Cal(Event(
                  title: launch.name,
                  description: launch.details ??
                      FlutterI18n.translate(
                        context,
                        'spacex.launch.page.no_description',
                      ),
                  location: launch.launchpad.name ??
                      FlutterI18n.translate(
                        context,
                        'spacex.other.unknown',
                      ),
                  startDate: launch.localLaunchDate,
                  endDate: launch.localLaunchDate.add(
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
          translationParams: {'launchpad': launch.launchpad.name},
        ),
        onTap: launch.launchpad != null
            ? () => Navigator.pushNamed(
                  context,
                  LaunchpadPage.route,
                  arguments: {'launchId': launch.id},
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
        subtitle: launch.staticFireDate == null
            ? FlutterI18n.translate(
                context,
                'spacex.home.tab.static_fire.body_unknown',
              )
            : FlutterI18n.translate(
                context,
                launch.staticFireDate.isBefore(DateTime.now())
                    ? 'spacex.home.tab.static_fire.body_done'
                    : 'spacex.home.tab.static_fire.body',
                translationParams: {'date': launch.getStaticFireDate(context)},
              ),
      ),
      Separator.divider(indent: 72),
      if (launch.rocket.hasFairings)
        ListCell.icon(
          icon: Icons.directions_boat,
          title: FlutterI18n.translate(
            context,
            'spacex.home.tab.fairings.title',
          ),
          subtitle: fairingSubtitle(context, launch.rocket.fairings),
        )
      else
        ListCell.svg(
          context: context,
          image: 'assets/icons/capsule.svg',
          title: FlutterI18n.translate(
            context,
            'spacex.home.tab.capsule.title',
          ),
          subtitle: capsuleSubtitle(context, launch.rocket.getSinglePayload),
          onTap: launch.rocket.hasCapsule
              ? () => Navigator.pushNamed(
                    context,
                    CapsulePage.route,
                    arguments: {
                      'launchId': launch.id,
                    },
                  )
              : null,
        ),
      Separator.divider(indent: 72),
      AbsorbPointer(
        absorbing: launch.rocket.isFirstStageNull,
        child: ListCell.svg(
          context: context,
          image: 'assets/icons/fins.svg',
          title: FlutterI18n.translate(
            context,
            'spacex.home.tab.first_stage.title',
          ),
          subtitle: launch.rocket.isHeavy
              ? FlutterI18n.translate(
                  context,
                  launch.rocket.isFirstStageNull
                      ? 'spacex.home.tab.first_stage.body_null'
                      : 'spacex.home.tab.first_stage.heavy_dialog.body',
                )
              : coreSubtitle(
                  context: context,
                  core: launch.rocket.getSingleCore,
                  isSideCore:
                      launch.rocket.isSideCore(launch.rocket.getSingleCore),
                ),
          onTap: !launch.rocket.isFirstStageNull
              ? () => launch.rocket.isHeavy
                  ? showHeavyDialog(context, launch)
                  : openCorePage(
                      context: context,
                      launchId: launch.id,
                      coreId: launch.rocket.getSingleCore.id,
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
        subtitle: landingSubtitle(context, launch.rocket.getSingleCore),
        onTap: launch.rocket.getSingleCore.landpad != null
            ? () => Navigator.pushNamed(
                  context,
                  LandpadPage.route,
                  arguments: {
                    'launchId': launch.id,
                    'coreId': launch.rocket.getSingleCore.id,
                  },
                )
            : null,
      ),
      Separator.divider(indent: 72)
    ]);
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

  void showHeavyDialog(BuildContext context, Launch upcomingLaunch) =>
      showBottomRoundDialog(
        context: context,
        title: FlutterI18n.translate(
          context,
          'spacex.home.tab.first_stage.heavy_dialog.title',
        ),
        children: [
          for (final core in upcomingLaunch.rocket.cores)
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
                subtitle: coreSubtitle(
                  context: context,
                  core: core,
                  isSideCore: upcomingLaunch.rocket.isSideCore(core),
                ),
                onTap: () => openCorePage(
                  context: context,
                  launchId: upcomingLaunch.id,
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

  String landingSubtitle(BuildContext context, Core core) {
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

  String payloadSubtitle(BuildContext context, List<Payload> payloads) {
    const maxPayload = 3;
    final buffer = StringBuffer();
    final payloadList = payloads.sublist(
      0,
      payloads.length > maxPayload ? maxPayload : payloads.length,
    );

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
            (i + 1 == payloadList.length ? '' : ', '),
      );
    }

    return FlutterI18n.translate(
      context,
      'spacex.home.tab.mission.body',
      translationParams: {'payloads': buffer.toString()},
    );
  }

  String fairingSubtitle(BuildContext context, FairingsDetails fairing) =>
      fairing.reused == null && fairing.recoveryAttempt == null
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

  String coreSubtitle({BuildContext context, Core core, bool isSideCore}) =>
      core.id == null || core.reused == null
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

  String capsuleSubtitle(BuildContext context, Payload payload) =>
      payload.capsule.serial == null
          ? FlutterI18n.translate(context, 'spacex.home.tab.capsule.body_null')
          : FlutterI18n.translate(
              context,
              'spacex.home.tab.capsule.body',
              translationParams: {
                'reused': payload.reused
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
