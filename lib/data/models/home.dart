import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/photos.dart';
import '../../util/url.dart';
import '../classes/abstract/query_model.dart';
import 'index.dart';

/// Storages essencial data from the next scheduled launch.
/// Used in the 'Home' tab, under the SpaceX screen.
class HomeModel extends QueryModel {
  HomeModel(BuildContext context) : super(context);

  @override
  Future loadData([BuildContext context]) async {
    if (await canLoadData()) {
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
    } else if (launch.tentativeTime) {
      Provider.of<AppModel>(context).notifications.cancelAll();
    }
  }

  Future _scheduleNotification({
    BuildContext context,
    int id,
    String time,
    Duration subtract,
  }) async {
    await Provider.of<AppModel>(context).notifications.schedule(
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
          androidAllowWhileIdle: true,
        );
  }

  String vehicle(BuildContext context) => FlutterI18n.translate(
        context,
        'spacex.home.tab.mission.title',
        {'rocket': launch.rocket.name},
      );

  String payload(BuildContext context) {
    final StringBuffer buffer = StringBuffer();
    const maxPayload = 3;

    final List<Payload> payloads = launch.rocket.secondStage.payloads.sublist(
      0,
      launch.rocket.secondStage.payloads.length > maxPayload
          ? maxPayload
          : launch.rocket.secondStage.payloads.length,
    );

    for (int i = 0; i < payloads.length; ++i) {
      buffer.write(FlutterI18n.translate(
            context,
            'spacex.home.tab.mission.body_payload',
            {'name': payloads[i].id, 'orbit': payloads[i].orbit},
          ) +
          (i + 1 == payloads.length ? '' : ', '));
    }

    return FlutterI18n.translate(
      context,
      'spacex.home.tab.mission.body',
      {'payloads': buffer.toString()},
    );
  }

  String launchDate(BuildContext context) => launch.tentativeTime
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

  String launchpad(BuildContext context) => FlutterI18n.translate(
        context,
        'spacex.home.tab.launchpad.body',
        {'launchpad': launch.launchpadName},
      );

  String staticFire(BuildContext context) => launch.staticFireDate == null
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

  String fairings(BuildContext context) => FlutterI18n.translate(
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

  String firstStage(BuildContext context) {
    if (launch.rocket.isHeavy) {
      return FlutterI18n.translate(
        context,
        launch.rocket.isFirstStageNull
            ? 'spacex.home.tab.first_stage.body_null'
            : 'spacex.home.tab.first_stage.heavy_dialog.body',
      );
    } else {
      return core(context, launch.rocket.getSingleCore);
    }
  }

  String core(BuildContext context, Core core) {
    final String coreType = <String>[
      FlutterI18n.translate(context, 'spacex.home.tab.first_stage.booster'),
      FlutterI18n.translate(context, 'spacex.home.tab.first_stage.side_core'),
    ][launch.rocket.isSideCore(core) ? 1 : 0];

    if (core.id == null) {
      return FlutterI18n.translate(
        context,
        launch.rocket.isHeavy
            ? 'spacex.home.tab.first_stage.heavy_dialog.core_null_body'
            : 'spacex.home.tab.first_stage.body_null',
      );
    } else {
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
  }

  String capsule(BuildContext context) =>
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
