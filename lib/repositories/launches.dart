import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/index.dart';
import '../models/launch.dart';
import '../providers/index.dart';
import '../services/api_service.dart';
import 'index.dart';

enum LaunchType { upcoming, latest }

/// Repository that holds a list of launches.
class LaunchesRepository extends BaseRepository {
  List<Launch> allLaunches;
  List<Launch> upcomingLaunches;
  List<Launch> latestLaunches;

  List<String> upcomingPhotos;
  List<String> latestPhotos;

  LaunchesRepository(BuildContext context) : super(context);

  @override
  Future<void> loadData() async {
    // Try to load the data using [ApiService]
    try {
      // Receives the data and parse it
      final Response<List> response = await ApiService.getLaunches();

      allLaunches = [for (final item in response.data) Launch.fromJson(item)];

      upcomingLaunches = allLaunches.where((launch) => launch.upcoming).toList()
        ..sort((a, b) => sortLaunches(LaunchType.upcoming, a, b));

      latestLaunches = allLaunches.where((launch) => !launch.upcoming).toList()
        ..sort((a, b) => sortLaunches(LaunchType.latest, a, b));

      upcomingPhotos ??= upcomingLaunches.first.photos;
      upcomingPhotos.shuffle();

      latestPhotos ??= latestLaunches.first.photos;
      latestPhotos.shuffle();

      finishLoading();
    } catch (_) {
      receivedError();
    }
  }

  List<String> photos(LaunchType type) =>
      type == LaunchType.upcoming ? upcomingPhotos : latestPhotos;

  List<Launch> launches(LaunchType type) =>
      type == LaunchType.upcoming ? upcomingLaunches : latestLaunches;

  Launch getLaunch(int index) => allLaunches[index - 1];

  Launch get nextLaunch => upcomingLaunches?.first;

  Future<void> initNotifications(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool updateNotifications;

    // Checks if is necessary to update scheduled notifications
    try {
      updateNotifications =
          prefs.getString('notifications.launches.upcoming') !=
              nextLaunch.launchDate.toIso8601String();
    } catch (e) {
      updateNotifications = true;
    }

    // Update notifications if necessary
    if (updateNotifications && !nextLaunch.tentativeTime) {
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
        nextLaunch.launchDate.toIso8601String(),
      );
    } else if (nextLaunch.tentativeTime) {
      context.read<NotificationsProvider>().notifications.cancelAll();
    }
  }

  Future _scheduleNotification({
    BuildContext context,
    int id,
    String time,
    Duration subtract,
  }) async {
    await context.read<NotificationsProvider>().notifications.schedule(
          id,
          FlutterI18n.translate(context, 'spacex.notifications.launches.title'),
          FlutterI18n.translate(
            context,
            'spacex.notifications.launches.body',
            {
              'rocket': nextLaunch.rocket.name,
              'payload': nextLaunch.rocket.secondStage.getPayload(0).id,
              'orbit': nextLaunch.rocket.secondStage.getPayload(0).orbit,
              'time': time,
            },
          ),
          nextLaunch.launchDate.subtract(subtract),
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
        {'rocket': nextLaunch.rocket.name},
      );

  String payload(BuildContext context) {
    final StringBuffer buffer = StringBuffer();
    const maxPayload = 3;

    final List<Payload> payloads =
        nextLaunch.rocket.secondStage.payloads.sublist(
      0,
      nextLaunch.rocket.secondStage.payloads.length > maxPayload
          ? maxPayload
          : nextLaunch.rocket.secondStage.payloads.length,
    );

    for (int i = 0; i < payloads.length; ++i) {
      buffer.write(
        FlutterI18n.translate(
              context,
              'spacex.home.tab.mission.body_payload',
              {'name': payloads[i].id, 'orbit': payloads[i].orbit},
            ) +
            (i + 1 == payloads.length ? '' : ', '),
      );
    }

    return FlutterI18n.translate(
      context,
      'spacex.home.tab.mission.body',
      {'payloads': buffer.toString()},
    );
  }

  String launchDate(BuildContext context) => nextLaunch.tentativeTime
      ? FlutterI18n.translate(
          context,
          'spacex.home.tab.date.body_upcoming',
          {'date': nextLaunch.getTentativeDate},
        )
      : FlutterI18n.translate(
          context,
          'spacex.home.tab.date.body',
          {
            'date': nextLaunch.getTentativeDate,
            'time': nextLaunch.getShortTentativeTime
          },
        );

  String launchpad(BuildContext context) => FlutterI18n.translate(
        context,
        'spacex.home.tab.launchpad.body',
        {'launchpad': nextLaunch.launchpadName},
      );

  String staticFire(BuildContext context) => nextLaunch.staticFireDate == null
      ? FlutterI18n.translate(
          context,
          'spacex.home.tab.static_fire.body_unknown',
        )
      : FlutterI18n.translate(
          context,
          nextLaunch.staticFireDate.isBefore(DateTime.now())
              ? 'spacex.home.tab.static_fire.body_done'
              : 'spacex.home.tab.static_fire.body',
          {'date': nextLaunch.getStaticFireDate(context)},
        );

  String fairings(BuildContext context) =>
      nextLaunch.rocket.fairing.reused == null &&
              nextLaunch.rocket.fairing.recoveryAttempt == null
          ? FlutterI18n.translate(
              context,
              'spacex.home.tab.fairings.body_null',
            )
          : nextLaunch.rocket.fairing.reused != null &&
                  nextLaunch.rocket.fairing.recoveryAttempt == null
              ? FlutterI18n.translate(
                  context,
                  nextLaunch.rocket.fairing.reused == true
                      ? 'spacex.home.tab.fairings.body_reused'
                      : 'spacex.home.tab.fairings.body_new',
                )
              : FlutterI18n.translate(
                  context,
                  'spacex.home.tab.fairings.body',
                  {
                    'reused': FlutterI18n.translate(
                      context,
                      nextLaunch.rocket.fairing.reused == true
                          ? 'spacex.home.tab.fairings.body_reused'
                          : 'spacex.home.tab.fairings.body_new',
                    ),
                    'catched': FlutterI18n.translate(
                      context,
                      nextLaunch.rocket.fairing.recoveryAttempt == true
                          ? 'spacex.home.tab.fairings.body_catching'
                          : 'spacex.home.tab.fairings.body_dispensed',
                    )
                  },
                );

  String firstStage(BuildContext context) => nextLaunch.rocket.isHeavy
      ? FlutterI18n.translate(
          context,
          nextLaunch.rocket.isFirstStageNull
              ? 'spacex.home.tab.first_stage.body_null'
              : 'spacex.home.tab.first_stage.heavy_dialog.body',
        )
      : core(context, nextLaunch.rocket.getSingleCore);

  String core(BuildContext context, Core core) =>
      core.id == null || core.reused == null
          ? FlutterI18n.translate(
              context,
              'spacex.home.tab.first_stage.body_null',
            )
          : FlutterI18n.translate(
              context,
              'spacex.home.tab.first_stage.body',
              {
                'booster': FlutterI18n.translate(
                  context,
                  nextLaunch.rocket.isSideCore(core)
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

  String capsule(BuildContext context) =>
      nextLaunch.rocket.secondStage.getPayload(0).capsuleSerial == null
          ? FlutterI18n.translate(context, 'spacex.home.tab.capsule.body_null')
          : FlutterI18n.translate(
              context,
              'spacex.home.tab.capsule.body',
              {
                'reused': nextLaunch.rocket.secondStage.getPayload(0).reused
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

  String landing(BuildContext context) {
    final Core core = nextLaunch.rocket.getSingleCore;

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
        {'type': core.landingType},
      );
    } else {
      return FlutterI18n.translate(
        context,
        'spacex.home.tab.landing.body',
        {'zone': core.landingZone},
      );
    }
  }
}

int sortLaunches(LaunchType type, Launch a, Launch b) =>
    type == LaunchType.upcoming
        ? a.number.compareTo(b.number)
        : b.number.compareTo(a.number);
