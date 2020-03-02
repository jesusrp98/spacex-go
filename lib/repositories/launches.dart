import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/index.dart';
import '../services/index.dart';
import 'index.dart';

enum LaunchType { upcoming, latest }

/// Repository that holds a list of launches.
class LaunchesRepository extends BaseRepository {
  final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();

  List<Launch> allLaunches;
  List<Launch> upcomingLaunches;
  List<Launch> latestLaunches;

  LaunchesRepository(BuildContext context) : super(context) {
    init();
  }

  /// Initializes the notifications system
  Future<void> init() async {
    await notifications.initialize(const InitializationSettings(
      AndroidInitializationSettings('notification_launch'),
      IOSInitializationSettings(),
    ));
  }

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

      // Adds notifications to queue
      await initNotifications();

      finishLoading();
    } on Exception catch (e) {
      print(e);
      receivedError();
    }
  }

  List<Launch> launches(LaunchType type) =>
      type == LaunchType.upcoming ? upcomingLaunches : latestLaunches;

  Launch getLaunch(int index) => allLaunches[index - 1];

  Launch get nextLaunch => upcomingLaunches?.first;

  Future<void> initNotifications() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool updateNotifications;

    // Checks if is necessary to update scheduled notifications
    try {
      updateNotifications =
          prefs.getString('notifications.launches.upcoming') !=
              nextLaunch.launchDate.toIso8601String();
    } catch (_) {
      updateNotifications = true;
    }

    if (updateNotifications) {
      // Deletes previos notifications
      notifications.cancelAll();

      if (!nextLaunch.tentativeTime) {
        // T - 1 day notification
        await _scheduleNotification(
          id: 0,
          time: FlutterI18n.translate(
            context,
            'spacex.notifications.launches.time_tomorrow',
          ),
          subtract: Duration(days: 1),
        );

        // T - 1 hour notification
        await _scheduleNotification(
          id: 1,
          time: FlutterI18n.translate(
            context,
            'spacex.notifications.launches.time_hour',
          ),
          subtract: Duration(hours: 1),
        );

        // T - 30 minutes notification
        await _scheduleNotification(
          id: 2,
          time: FlutterI18n.translate(
            context,
            'spacex.notifications.launches.time_minutes',
            translationParams: {'minutes': '30'},
          ),
          subtract: Duration(minutes: 30),
        );
      }

      // Update storaged launch date
      prefs.setString(
        'notifications.launches.upcoming',
        nextLaunch.launchDate.toIso8601String(),
      );
    }
  }

  Future<void> _scheduleNotification({
    BuildContext context,
    int id,
    String time,
    Duration subtract,
  }) async {
    await notifications.schedule(
      id,
      FlutterI18n.translate(context, 'spacex.notifications.launches.title'),
      FlutterI18n.translate(
        context,
        'spacex.notifications.launches.body',
        translationParams: {
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
}

int sortLaunches(LaunchType type, Launch a, Launch b) =>
    type == LaunchType.upcoming
        ? a.number.compareTo(b.number)
        : b.number.compareTo(a.number);
