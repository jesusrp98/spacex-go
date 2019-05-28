import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:row_collection/row_collection.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/photos.dart';
import '../util/url.dart';
import 'app_model.dart';
import 'launch.dart';
import 'query_model.dart';
import 'rocket.dart';

/// SPACEX HOME TAB MODEL
/// Storages essencial data from the next scheduled launch.
/// Used in the 'Home' tab, under the SpaceX screen.
class SpacexHomeModel extends QueryModel {
  @override
  Future loadData([BuildContext context]) async {
    if (await connectionFailure())
      receivedError();
    else {
      items.clear();

      // Add parsed item
      items.add(Launch.fromJson(await fetchData(Url.nextLaunch)));

      // Adds notifications to queue
      await initNotifications(context);

      // Add photos & shuffle them
      if (photos.isEmpty) {
        photos.addAll(SpaceXPhotos.home);
        photos.shuffle();
      }
      finishLoading();
    }
  }

  Launch get launch => getItem(0);

  Future initNotifications(BuildContext context) async {
    bool updateNotifications;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Checks if is necessary to update scheduled notifications
    try {
      updateNotifications =
          prefs.getString('notifications.launches.upcoming') !=
              launch.launchDate.toIso8601String();
    } catch (e) {
      updateNotifications = true;
    }

    // Update notifications if necessary
    if (updateNotifications && !launch.tentativeTime) {
      // T - 1 day notification
      await _scheduleNotification(
        id: 0,
        context: context,
        time: FlutterI18n.translate(
          context,
          'spacex.notifications.launches.time_tomorrow',
        ),
        subtract: Duration(days: 1),
      );

      // T - 1 hour notification
      await _scheduleNotification(
        id: 1,
        context: context,
        time: FlutterI18n.translate(
          context,
          'spacex.notifications.launches.time_hour',
        ),
        subtract: Duration(hours: 1),
      );

      // T - 30 minutes notification
      await _scheduleNotification(
        id: 2,
        context: context,
        time: FlutterI18n.translate(
          context,
          'spacex.notifications.launches.time_minutes',
          {'minutes': '30'},
        ),
        subtract: Duration(minutes: 30),
      );

      // Update storaged launch date
      prefs.setString(
        'notifications.launches.upcoming',
        launch.launchDate.toIso8601String(),
      );
    } else if (launch.tentativeTime)
      ScopedModel.of<AppModel>(context).notifications.cancelAll();
  }

  Future _scheduleNotification({
    BuildContext context,
    int id,
    String time,
    Duration subtract,
  }) async {
    await ScopedModel.of<AppModel>(context).notifications.schedule(
          id,
          FlutterI18n.translate(context, 'spacex.notifications.launches.title'),
          FlutterI18n.translate(
            context,
            'spacex.notifications.launches.body',
            {
              'rocket': launch.rocket.name,
              'payload': launch.rocket.secondStage.getPayload(0).id,
              'orbit': launch.rocket.secondStage.getPayload(0).orbit,
              'time': time,
            },
          ),
          launch.launchDate.subtract(subtract),
          NotificationDetails(
            AndroidNotificationDetails(
              'channel.launches',
              FlutterI18n.translate(
                context,
                'spacex.notifications.channel.launches.title',
              ),
              FlutterI18n.translate(
                context,
                'spacex.notifications.channel.launches.description',
              ),
              importance: Importance.High,
              color: Theme.of(context).primaryColor,
            ),
            IOSNotificationDetails(),
          ),
        );
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
              'name': launch.rocket.secondStage.getPayload(i).id,
              'orbit': launch.rocket.secondStage.getPayload(i).orbit
            },
          ) +
          (i + 1 == launch.rocket.secondStage.payloads.length ? '' : ', ');

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
      launch.rocket.secondStage.getPayload(0).capsuleSerial == null
          ? FlutterI18n.translate(context, 'spacex.home.tab.capsule.body_null')
          : FlutterI18n.translate(
              context,
              'spacex.home.tab.capsule.body',
              {
                'reused': launch.rocket.secondStage.getPayload(0).reused
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
            style: TextStyle(fontSize: 22, fontFamily: 'RobotoMono'),
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
                Icon(Icons.play_arrow, size: 30),
                Separator.smallSpacer(),
                Text(
                  FlutterI18n.translate(
                    context,
                    'spacex.home.tab.live_mission',
                  ).toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontFamily: 'RobotoMono'),
                ),
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
