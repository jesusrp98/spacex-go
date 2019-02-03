import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:http/http.dart' as http;

import '../util/url.dart';
import '../widgets/separator.dart';
import 'launch.dart';
import 'query_model.dart';
import 'rocket.dart';

/// SPACEX HOME TAB MODEL
/// Storages essencial data from the next scheduled launch.
/// Used in the 'Home' tab, under the SpaceX screen.
class SpacexHomeModel extends QueryModel {
  Launch launch;

  @override
  Future loadData() async {
    // Get item by http call
    final response = await http.get(Url.nextLaunch);

    // Clear old data
    items.clear();

    // Add parsed item
    launch = Launch.fromJson(json.decode(response.body));

    // Add photos & shuffle them
    if (photos.isEmpty) {
      photos.addAll(Url.spacexHomeScreen);
      photos.shuffle();
    }

    // Finished loading data
    setLoading(false);
  }

  String vehicle(context) => FlutterI18n.translate(
        context,
        'spacex.home.tab.mission.title',
        {'rocket': launch.rocket.name},
      );

  String payload(context) {
    String aux = '';

    for (int i = 0; i < launch.rocket.secondStage.payloads.length; ++i)
      aux += FlutterI18n.translate(
            context,
            'spacex.home.tab.mission.body_payload',
            {
              'name': launch.rocket.secondStage.payloads[i].id,
              'orbit': launch.rocket.secondStage.payloads[i].orbit
            },
          ) +
          (i + 1 == launch.rocket.secondStage.payloads.length ? '.' : ', ');

    return FlutterI18n.translate(
      context,
      'spacex.home.tab.mission.body',
      {'payloads': aux},
    );
  }

  String launchDate(context) => launch.tentativeTime
      ? FlutterI18n.translate(
          context,
          'spacex.home.tab.date.body_upcoming',
          {'date': launch.getTentativeDate},
        )
      : FlutterI18n.translate(
          context,
          'spacex.home.tab.date.body',
          {'date': launch.getTentativeDate, 'time': launch.getTentativeTime},
        );

  String launchpad(context) => FlutterI18n.translate(
        context,
        'spacex.home.tab.launchpad.body',
        {'launchpad': launch.launchpadName},
      );

  String staticFire(context) => launch.staticFireDate == null
      ? FlutterI18n.translate(
          context,
          'spacex.home.tab.static_fire.body_unknown',
        )
      : FlutterI18n.translate(
          context,
          launch.staticFireDate.isBefore(DateTime.now())
              ? 'spacex.home.tab.static_fire.body_done'
              : 'spacex.home.tab.static_fire.body',
          {'date': launch.getStaticFireDate(context)},
        );

  String fairings(context) => FlutterI18n.translate(
        context,
        'spacex.home.tab.fairings.body',
        {
          'reused': FlutterI18n.translate(
            context,
            launch.rocket.fairing.reused != null && launch.rocket.fairing.reused
                ? 'spacex.home.tab.fairings.body_reused'
                : 'spacex.home.tab.fairings.body_new',
          ),
          'catched': launch.rocket.fairing.recoveryAttempt != null &&
                  launch.rocket.fairing.recoveryAttempt == true
              ? FlutterI18n.translate(
                  context,
                  'spacex.home.tab.fairings.body_catching',
                  {'ship': launch.rocket.fairing.ship},
                )
              : FlutterI18n.translate(
                  context,
                  'spacex.home.tab.fairings.body_dispensed',
                )
        },
      );

  String firstStage(context) {
    if (launch.rocket.isHeavy)
      return FlutterI18n.translate(
        context,
        launch.rocket.isFirstStageNull
            ? 'spacex.home.tab.first_stage.body_null'
            : 'spacex.home.tab.first_stage.heavy_dialog.body',
      );
    else
      return core(context, launch.rocket.getSingleCore);
  }

  String core(context, Core core) {
    String coreType = <String>[
      FlutterI18n.translate(context, 'spacex.home.tab.first_stage.booster'),
      FlutterI18n.translate(context, 'spacex.home.tab.first_stage.side_core'),
    ][launch.rocket.isSideCore(core) ? 1 : 0];

    if (core.id == null)
      return FlutterI18n.translate(
        context,
        launch.rocket.isHeavy
            ? 'spacex.home.tab.first_stage.heavy_dialog.core_null_body'
            : 'spacex.home.tab.first_stage.body_null',
      );
    else
      return core.landingIntent != null
          ? FlutterI18n.translate(
              context,
              'spacex.home.tab.first_stage.body',
              {
                'booster': coreType,
                'reused': FlutterI18n.translate(
                  context,
                  core.reused
                      ? 'spacex.home.tab.first_stage.body_reused'
                      : 'spacex.home.tab.first_stage.body_new',
                ),
                'landing': core.landingIntent
                    ? core.landingZone == null
                        ? FlutterI18n.translate(
                            context,
                            'spacex.home.tab.first_stage.body_landing_type',
                            {'type': core.landingType},
                          )
                        : FlutterI18n.translate(
                            context,
                            'spacex.home.tab.first_stage.body_landing',
                            {'landingpad': core.landingZone},
                          )
                    : FlutterI18n.translate(
                        context,
                        'spacex.home.tab.first_stage.body_dispended',
                      )
              },
            )
          : FlutterI18n.translate(
              context,
              'spacex.home.tab.first_stage.body_unknown_landing',
              {
                'booster': coreType,
                'reused': FlutterI18n.translate(
                  context,
                  core.reused != null && core.reused
                      ? 'spacex.home.tab.first_stage.body_reused'
                      : 'spacex.home.tab.first_stage.body_new',
                )
              },
            );
  }

  String capsule(context) =>
      launch.rocket.secondStage.payloads[0].capsuleSerial == null
          ? FlutterI18n.translate(context, 'spacex.home.tab.capsule.body_null')
          : FlutterI18n.translate(
              context,
              'spacex.home.tab.capsule.body',
              {
                'reused': launch.rocket.secondStage.payloads[0].reused
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

/// COUNTDOWN WIDGET
/// Stateful widget used to display a countdown to the next launch.
class LaunchCountdown extends StatefulWidget {
  final Launch launch;

  LaunchCountdown(this.launch);
  State createState() => _LaunchCountdownState();
}

class _LaunchCountdownState extends State<LaunchCountdown>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: widget.launch.launchDate.millisecondsSinceEpoch -
            DateTime.now().millisecondsSinceEpoch,
      ),
    );
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Countdown(
      animation: StepTween(
        begin: widget.launch.launchDate.millisecondsSinceEpoch,
        end: DateTime.now().millisecondsSinceEpoch,
      ).animate(_controller),
      launchDate: widget.launch.launchDate,
      name: widget.launch.name,
      url: widget.launch.getVideo,
    );
  }
}

class Countdown extends AnimatedWidget {
  final Animation<int> animation;
  final DateTime launchDate;
  final String name, url;

  Countdown({
    Key key,
    this.animation,
    this.launchDate,
    this.name,
    this.url,
  }) : super(key: key, listenable: animation);

  @override
  build(BuildContext context) {
    return launchDate.isAfter(DateTime.now())
        ? Text(
            getTimer(launchDate.difference(DateTime.now())),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline
                .copyWith(fontFamily: 'RobotoMono'),
          )
        : InkWell(
            onTap: () async => await FlutterWebBrowser.openWebPage(
                  url: url,
                  androidToolbarColor: Theme.of(context).primaryColor,
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.play_arrow, size: 32.0),
                Separator.spacer(width: 8.0),
                Text(
                  FlutterI18n.translate(context, 'spacex.home.tab.live_mission')
                      .toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .copyWith(fontFamily: 'RobotoMono'),
                ),
                Separator.spacer(width: 8.0)
              ],
            ),
          );
  }

  String getTimer(Duration d) =>
      'T-' +
      d.inDays.toString().padLeft(2, '0') +
      'd:' +
      (d.inHours - d.inDays * Duration.hoursPerDay).toString().padLeft(2, '0') +
      'h:' +
      (d.inMinutes -
              d.inDays * Duration.minutesPerDay -
              (d.inHours - d.inDays * Duration.hoursPerDay) *
                  Duration.minutesPerHour)
          .toString()
          .padLeft(2, '0') +
      'm:' +
      (d.inSeconds % 60).toString().padLeft(2, '0') +
      's';
}
