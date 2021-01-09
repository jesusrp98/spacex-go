import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../models/index.dart';

/// Serves as a way to communicate with the notification system.
class NotificationsProvider with ChangeNotifier {
  final FlutterLocalNotificationsPlugin service;
  final NotificationDetails notificationDetails;
  final InitializationSettings initializationSettings;

  NotificationsProvider(
    this.service, {
    this.notificationDetails,
    this.initializationSettings,
  }) : assert(service != null);

  /// Initializes the notifications system
  Future<void> init() async {
    try {
      await service.initialize(initializationSettings);
    } catch (_) {}
  }

  static Future<void> setNextLaunchDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
      'notifications.launches.upcoming',
      date.toIso8601String(),
    );
  }

  /// Checks if it's necceasry to update scheduled notifications
  static Future<bool> needsToUpdate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getString('notifications.launches.upcoming') !=
          date.toIso8601String();
    } catch (_) {
      return true;
    }
  }

  /// Schedule new notifications
  Future<void> scheduleNotification({
    @required int id,
    @required String title,
    @required String body,
    @required tz.TZDateTime dateTime,
  }) async =>
      service.zonedSchedule(
        id,
        title,
        body,
        dateTime,
        notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
      );

  Future<void> updateNotifications(
    BuildContext context, {
    @required Launch nextLaunch,
  }) async {
    try {
      if (nextLaunch != null && await needsToUpdate(nextLaunch.launchDate)) {
        tz.initializeTimeZones();

        final localTimeZone = await FlutterNativeTimezone.getLocalTimezone();
        final localLaunchDate = nextLaunch.localLaunchDate;

        // Cancels all previous schedule notifications because the date has changed
        service.cancelAll();

        // If the date and time of the next launch has been set
        if (!nextLaunch.tentativeTime) {
          final localDate = tz.TZDateTime.from(
            localLaunchDate,
            tz.getLocation(localTimeZone),
          );

          // T-1 day notification
          await scheduleNotification(
            id: 0,
            title: FlutterI18n.translate(
              context,
              'spacex.notifications.launches.title',
            ),
            body: FlutterI18n.translate(
              context,
              'spacex.notifications.launches.body',
              translationParams: {
                'rocket': nextLaunch.rocket.name,
                'payload': nextLaunch.rocket.getSinglePayload.name,
                'orbit': nextLaunch.rocket.getSinglePayload.orbit,
                'time': FlutterI18n.translate(
                  context,
                  'spacex.notifications.launches.time_tomorrow',
                ),
              },
            ),
            dateTime: localDate.subtract(Duration(days: 1)),
          );

          // T-1 hour notification
          await scheduleNotification(
            id: 1,
            title: FlutterI18n.translate(
              context,
              'spacex.notifications.launches.title',
            ),
            body: FlutterI18n.translate(
              context,
              'spacex.notifications.launches.body',
              translationParams: {
                'rocket': nextLaunch.rocket.name,
                'payload': nextLaunch.rocket.getSinglePayload.name,
                'orbit': nextLaunch.rocket.getSinglePayload.orbit,
                'time': FlutterI18n.translate(
                  context,
                  'spacex.notifications.launches.time_hour',
                ),
              },
            ),
            dateTime: localDate.subtract(Duration(hours: 1)),
          );

          // T-30 minutes notification
          await scheduleNotification(
            id: 2,
            title: FlutterI18n.translate(
              context,
              'spacex.notifications.launches.title',
            ),
            body: FlutterI18n.translate(
              context,
              'spacex.notifications.launches.body',
              translationParams: {
                'rocket': nextLaunch.rocket.name,
                'payload': nextLaunch.rocket.getSinglePayload.name,
                'orbit': nextLaunch.rocket.getSinglePayload.orbit,
                'time': FlutterI18n.translate(
                  context,
                  'spacex.notifications.launches.time_minutes',
                  translationParams: {
                    'minutes': '30',
                  },
                ),
              },
            ),
            dateTime: localDate.subtract(Duration(minutes: 30)),
          );
        }

        await setNextLaunchDate(nextLaunch.launchDate);
      }
    } catch (_) {}
  }
}
