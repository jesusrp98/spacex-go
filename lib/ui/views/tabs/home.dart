import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cherry_components/cherry_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:row_collection/row_collection.dart';

import '../../../cubits/index.dart';
import '../../../models/index.dart';
import '../../../utils/index.dart';
import '../../widgets/index.dart';
import '../launches/index.dart';

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
      title: context.translate('spacex.home.title'),
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
                        onTap: () => context.openUrl(launch.getVideo),
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
                                context
                                    .translate('spacex.home.tab.live_mission'),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.robotoMono(
                                  fontSize: 24,
                                  color: Colors.white,
                                  shadows: [
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
        title: context.translate(
          'spacex.home.tab.mission.title',
          parameters: {'rocket': launch.rocket.name},
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
        title: context.translate(
          'spacex.home.tab.date.title',
        ),
        subtitle: launch.tentativeTime
            ? context.translate(
                'spacex.home.tab.date.body_upcoming',
                parameters: {'date': launch.getTentativeDate},
              )
            : context.translate(
                'spacex.home.tab.date.body',
                parameters: {
                  'date': launch.getTentativeDate,
                  'time': launch.getShortTentativeTime
                },
              ),
        onTap: !launch.tentativeTime
            ? () async {
                await Add2Calendar.addEvent2Cal(Event(
                  title: launch.name,
                  description: launch.details ??
                      context.translate('spacex.launch.page.no_description'),
                  location: launch.launchpad.name ??
                      context.translate('spacex.other.unknown'),
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
        title: context.translate('spacex.home.tab.launchpad.title'),
        subtitle: context.translate(
          'spacex.home.tab.launchpad.body',
          parameters: {'launchpad': launch.launchpad.name},
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
        title: context.translate('spacex.home.tab.static_fire.title'),
        subtitle: launch.staticFireDate == null
            ? context.translate('spacex.home.tab.static_fire.body_unknown')
            : context.translate(
                launch.staticFireDate.isBefore(DateTime.now())
                    ? 'spacex.home.tab.static_fire.body_done'
                    : 'spacex.home.tab.static_fire.body',
                parameters: {'date': launch.getStaticFireDate(context)},
              ),
      ),
      Separator.divider(indent: 72),
      if (launch.rocket.hasFairings)
        ListCell.icon(
          icon: Icons.directions_boat,
          title: context.translate('spacex.home.tab.fairings.title'),
          subtitle: fairingSubtitle(context, launch.rocket.fairings),
        )
      else
        ListCell(
          leading: SvgPicture.asset(
            'assets/icons/capsule.svg',
            colorBlendMode: BlendMode.srcATop,
            width: 40,
            height: 40,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black45
                : null,
          ),
          title: context.translate('spacex.home.tab.capsule.title'),
          subtitle: capsuleSubtitle(context, launch.rocket.getSinglePayload),
          onTap: launch.rocket.hasCapsule
              ? () => Navigator.pushNamed(
                    context,
                    CapsulePage.route,
                    arguments: {'launchId': launch.id},
                  )
              : null,
        ),
      Separator.divider(indent: 72),
      AbsorbPointer(
        absorbing: launch.rocket.isFirstStageNull,
        child: ListCell(
          leading: SvgPicture.asset(
            'assets/icons/fins.svg',
            colorBlendMode: BlendMode.srcATop,
            width: 40,
            height: 40,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black45
                : null,
          ),
          title: context.translate('spacex.home.tab.first_stage.title'),
          subtitle: launch.rocket.isHeavy
              ? context.translate(
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
        title: context.translate('spacex.home.tab.landing.title'),
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
        title: context.translate(
          'spacex.home.tab.first_stage.heavy_dialog.title',
        ),
        padding: EdgeInsets.zero,
        children: [
          for (final core in upcomingLaunch.rocket.cores)
            AbsorbPointer(
              absorbing: core.id == null,
              child: ListCell(
                title: core.id != null
                    ? context.translate(
                        'spacex.dialog.vehicle.title_core',
                        parameters: {'serial': core.serial},
                      )
                    : context.translate(
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
      return context.translate('spacex.home.tab.landing.body_null');
    } else if (!core.landingAttempt) {
      return context.translate('spacex.home.tab.landing.body_expended');
    } else if (core.landpad == null && core.landingType != null) {
      return context.translate(
        'spacex.home.tab.landing.body_type',
        parameters: {'type': core.landingType},
      );
    } else {
      return context.translate(
        'spacex.home.tab.landing.body',
        parameters: {'zone': core.landpad.name},
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
        context.translate(
              'spacex.home.tab.mission.body_payload',
              parameters: {
                'name': payloads[i].name,
                'orbit': payloads[i].orbit
              },
            ) +
            (i + 1 == payloadList.length ? '' : ', '),
      );
    }

    return context.translate(
      'spacex.home.tab.mission.body',
      parameters: {'payloads': buffer.toString()},
    );
  }

  String fairingSubtitle(BuildContext context, FairingsDetails fairing) =>
      fairing.reused == null && fairing.recoveryAttempt == null
          ? context.translate('spacex.home.tab.fairings.body_null')
          : fairing.reused != null && fairing.recoveryAttempt == null
              ? context.translate(
                  fairing.reused == true
                      ? 'spacex.home.tab.fairings.body_reused'
                      : 'spacex.home.tab.fairings.body_new',
                )
              : context.translate(
                  'spacex.home.tab.fairings.body',
                  parameters: {
                    'reused': context.translate(
                      fairing.reused == true
                          ? 'spacex.home.tab.fairings.body_reused'
                          : 'spacex.home.tab.fairings.body_new',
                    ),
                    'catched': context.translate(
                      fairing.recoveryAttempt == true
                          ? 'spacex.home.tab.fairings.body_catching'
                          : 'spacex.home.tab.fairings.body_dispensed',
                    )
                  },
                );

  String coreSubtitle({BuildContext context, Core core, bool isSideCore}) =>
      core.id == null || core.reused == null
          ? context.translate('spacex.home.tab.first_stage.body_null')
          : context.translate(
              'spacex.home.tab.first_stage.body',
              parameters: {
                'booster': context.translate(
                  isSideCore
                      ? 'spacex.home.tab.first_stage.side_core'
                      : 'spacex.home.tab.first_stage.booster',
                ),
                'reused': context.translate(
                  core.reused
                      ? 'spacex.home.tab.first_stage.body_reused'
                      : 'spacex.home.tab.first_stage.body_new',
                ),
              },
            );

  String capsuleSubtitle(BuildContext context, Payload payload) =>
      payload.capsule?.serial == null
          ? context.translate('spacex.home.tab.capsule.body_null')
          : context.translate(
              'spacex.home.tab.capsule.body',
              parameters: {
                'reused': payload.reused
                    ? context.translate(
                        'spacex.home.tab.capsule.body_reused',
                      )
                    : context.translate(
                        'spacex.home.tab.capsule.body_new',
                      )
              },
            );
}
