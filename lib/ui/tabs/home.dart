import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';

import '../../models/index.dart';
import '../../repositories/index.dart';
import '../../util/menu.dart';
import '../../util/photos.dart';
import '../../util/routes.dart';
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
    final double _sliverHeight =
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.play_arrow, size: 50),
                            Text(
                              FlutterI18n.translate(
                                context,
                                'spacex.home.tab.live_mission',
                              ),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'RobotoMono',
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: const Offset(0, 0),
                                    blurRadius: 4,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Separator.none(),
          )
        : Separator.none();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LaunchesRepository>(
      builder: (context, model, child) => Scaffold(
        body: SliverPage<LaunchesRepository>.display(
          controller: _controller,
          title: FlutterI18n.translate(context, 'spacex.home.title'),
          opacity: model.nextLaunch?.isDateTooTentative == true &&
                  MediaQuery.of(context).orientation != Orientation.landscape
              ? 1.0
              : 0.64,
          counter: _headerDetails(context, model.nextLaunch),
          slides: List.from(SpaceXPhotos.home)..shuffle(),
          popupMenu: Menu.home,
          body: <Widget>[
            SliverToBoxAdapter(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Consumer<LaunchesRepository>(
      builder: (context, model, child) => Column(children: <Widget>[
        ListCell.icon(
          icon: Icons.public,
          trailing: Icon(Icons.chevron_right),
          title: FlutterI18n.translate(
            context,
            'spacex.home.tab.mission.title',
            translationParams: {'rocket': model.nextLaunch.rocket.name},
          ),
          subtitle: nextPayload,
          onTap: () => Navigator.pushNamed(
            context,
            Routes.launch,
            arguments: {'id': model.nextLaunch.number},
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
          subtitle: model.nextLaunch.tentativeTime
              ? FlutterI18n.translate(
                  context,
                  'spacex.home.tab.date.body_upcoming',
                  translationParams: {
                    'date': model.nextLaunch.getTentativeDate
                  },
                )
              : FlutterI18n.translate(
                  context,
                  'spacex.home.tab.date.body',
                  translationParams: {
                    'date': model.nextLaunch.getTentativeDate,
                    'time': model.nextLaunch.getShortTentativeTime
                  },
                ),
          onTap: () async {
            if (await Add2Calendar.addEvent2Cal(
              Event(
                title: model.nextLaunch.name,
                description: model.nextLaunch.details ??
                    FlutterI18n.translate(
                      context,
                      'spacex.launch.page.no_description',
                    ),
                location: model.nextLaunch.launchpadName,
                startDate: model.nextLaunch.launchDate,
                endDate: model.nextLaunch.launchDate.add(
                  Duration(minutes: 30),
                ),
              ),
            )) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Event added to the calendar'),
                ),
              );
            } else {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error while trying to add the event'),
                ),
              );
            }
          },
        ),
        Separator.divider(indent: 72),
        ListCell.icon(
          icon: Icons.location_on,
          trailing: Icon(Icons.chevron_right),
          title: FlutterI18n.translate(
            context,
            'spacex.home.tab.launchpad.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'spacex.home.tab.launchpad.body',
            translationParams: {'launchpad': model.nextLaunch.launchpadName},
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider<LaunchpadRepository>(
                create: (_) => LaunchpadRepository(
                  model.nextLaunch.launchpadId,
                  model.nextLaunch.launchpadName,
                ),
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
          subtitle: model.nextLaunch.staticFireDate == null
              ? FlutterI18n.translate(
                  context,
                  'spacex.home.tab.static_fire.body_unknown',
                )
              : FlutterI18n.translate(
                  context,
                  model.nextLaunch.staticFireDate.isBefore(DateTime.now())
                      ? 'spacex.home.tab.static_fire.body_done'
                      : 'spacex.home.tab.static_fire.body',
                  translationParams: {
                    'date': model.nextLaunch.getStaticFireDate(context)
                  },
                ),
        ),
        Separator.divider(indent: 72),
        if (model.nextLaunch.rocket.hasFairing)
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
            absorbing: model.nextLaunch.rocket.secondStage
                    .getPayload(0)
                    .capsuleSerial ==
                null,
            child: ListCell.svg(
              context: context,
              image: 'assets/icons/capsule.svg',
              trailing: Icon(
                Icons.chevron_right,
                color: model.nextLaunch.rocket.secondStage
                            .getPayload(0)
                            .capsuleSerial ==
                        null
                    ? Theme.of(context).disabledColor
                    : Theme.of(context).brightness == Brightness.light
                        ? Colors.black45
                        : Colors.white,
              ),
              title: FlutterI18n.translate(
                context,
                'spacex.home.tab.capsule.title',
              ),
              subtitle: nextCapsule,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider<CapsuleRepository>(
                    create: (_) => CapsuleRepository(
                      model.nextLaunch.rocket.secondStage
                          .getPayload(0)
                          .capsuleSerial,
                    ),
                    child: CapsulePage(),
                  ),
                  fullscreenDialog: true,
                ),
              ),
            ),
          ),
        Separator.divider(indent: 72),
        AbsorbPointer(
          absorbing: model.nextLaunch.rocket.isFirstStageNull,
          child: ListCell.svg(
            context: context,
            image: 'assets/icons/fins.svg',
            trailing: Icon(
              Icons.chevron_right,
              color: model.nextLaunch.rocket.isFirstStageNull
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).brightness == Brightness.light
                      ? Colors.black45
                      : Colors.white,
            ),
            title: FlutterI18n.translate(
              context,
              'spacex.home.tab.first_stage.title',
            ),
            subtitle: model.nextLaunch.rocket.isHeavy
                ? FlutterI18n.translate(
                    context,
                    model.nextLaunch.rocket.isFirstStageNull
                        ? 'spacex.home.tab.first_stage.body_null'
                        : 'spacex.home.tab.first_stage.heavy_dialog.body',
                  )
                : nextCore(model.nextLaunch.rocket.getSingleCore),
            onTap: () => model.nextLaunch.rocket.isHeavy
                ? showHeavyDialog(context)
                : openCorePage(
                    context,
                    model.nextLaunch.rocket.getSingleCore.id,
                  ),
          ),
        ),
        Separator.divider(indent: 72),
        AbsorbPointer(
          absorbing: model.nextLaunch.rocket.getSingleCore.landingZone == null,
          child: ListCell.icon(
            icon: Icons.center_focus_weak,
            trailing: Icon(
              Icons.chevron_right,
              color: model.nextLaunch.rocket.getSingleCore.landingZone == null
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).brightness == Brightness.light
                      ? Colors.black45
                      : Colors.white,
            ),
            title: FlutterI18n.translate(
              context,
              'spacex.home.tab.landing.title',
            ),
            subtitle: nextLanding,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider<LandpadRepository>(
                  create: (_) => LandpadRepository(
                    model.nextLaunch.rocket.getSingleCore.landingZone,
                  ),
                  child: LandpadPage(),
                ),
                fullscreenDialog: true,
              ),
            ),
          ),
        ),
        Separator.divider(indent: 72)
      ]),
    );
  }

  void showHeavyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => RoundDialog(
        title: FlutterI18n.translate(
          context,
          'spacex.home.tab.first_stage.heavy_dialog.title',
        ),
        children: [
          for (final core in context
              .read<LaunchesRepository>()
              .nextLaunch
              .rocket
              .firstStage)
            AbsorbPointer(
              absorbing: core.id == null,
              child: ListCell(
                title: core.id != null
                    ? FlutterI18n.translate(
                        context,
                        'spacex.dialog.vehicle.title_core',
                        translationParams: {'serial': core.id},
                      )
                    : FlutterI18n.translate(
                        context,
                        'spacex.home.tab.first_stage.heavy_dialog.core_null_title',
                      ),
                subtitle: nextCore(core),
                onTap: () => openCorePage(
                  context,
                  core.id,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 24,
                ),
              ),
            )
        ],
      ),
    );
  }

  void openCorePage(BuildContext context, String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider<CoreRepository>(
          create: (_) => CoreRepository(id),
          child: CoreDialog(),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  String get nextLanding {
    final core =
        context.read<LaunchesRepository>().nextLaunch.rocket.getSingleCore;

    if (core.id == null || core.landingIntent == null) {
      return FlutterI18n.translate(
        context,
        'spacex.home.tab.landing.body_null',
      );
    } else if (!core.landingIntent) {
      return FlutterI18n.translate(
        context,
        'spacex.home.tab.landing.body_expended',
      );
    } else if (core.landingZone == null && core.landingType != null) {
      return FlutterI18n.translate(
        context,
        'spacex.home.tab.landing.body_type',
        translationParams: {'type': core.landingType},
      );
    } else {
      return FlutterI18n.translate(
        context,
        'spacex.home.tab.landing.body',
        translationParams: {'zone': core.landingZone},
      );
    }
  }

  String get nextPayload {
    const maxPayload = 3;

    final StringBuffer buffer = StringBuffer();
    final payloadSize = context
        .read<LaunchesRepository>()
        .nextLaunch
        .rocket
        .secondStage
        .payloads
        .length;

    final payloads = context
        .read<LaunchesRepository>()
        .nextLaunch
        .rocket
        .secondStage
        .payloads
        .sublist(0, payloadSize > maxPayload ? maxPayload : payloadSize);

    for (int i = 0; i < payloads.length; ++i) {
      buffer.write(
        FlutterI18n.translate(
              context,
              'spacex.home.tab.mission.body_payload',
              translationParams: {
                'name': payloads[i].id,
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
        context.read<LaunchesRepository>().nextLaunch.rocket.fairing;

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
    final isSideCore =
        context.read<LaunchesRepository>().nextLaunch.rocket.isSideCore(core);

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
        .nextLaunch
        .rocket
        .secondStage
        .getPayload(0);

    return capsule.capsuleSerial == null
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
