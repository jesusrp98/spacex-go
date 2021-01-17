import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../models/index.dart';
import '../util/index.dart';

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

  /// Saves the current target launch date
  static Future<void> setNextLaunchDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
      'notifications.launches.upcoming',
      date.toIso8601String(),
    );
  }

  /// Clears previous set notifications if they exist
  Future<void> clearPreviousNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('notifications.launches.upcoming') != null) {
      service.cancelAll();
    }
  }

  /// Sets the target launch date to null
  static Future<void> resetNextLaunchDate() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('notifications.launches.upcoming', null);
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
        // Cancels all previous schedule notifications because the date has changed
        clearPreviousNotifications();

        // If the date and time of the next launch has been set
        if (!nextLaunch.tentativeTime) {
          tz.initializeTimeZones();

          final utcLaunchDate = tz.TZDateTime.from(
            nextLaunch.launchDate,
            tz.UTC,
          );

          final utcCurrentDate = tz.TZDateTime.now(tz.UTC);

          // T-1 day notification
          if (utcCurrentDate.add(Duration(days: 1)).isBefore(utcLaunchDate)) {
            await scheduleNotification(
              id: 0,
              title: translate(
                context,
                'spacex.notifications.launches.title',
              ),
              body: translate(
                context,
                'spacex.notifications.launches.body',
                translationParams: {
                  'rocket': nextLaunch.rocket.name,
                  'payload': nextLaunch.rocket.getSinglePayload.name,
                  'orbit': nextLaunch.rocket.getSinglePayload.orbit,
                  'time': translate(
                    context,
                    'spacex.notifications.launches.time_tomorrow',
                  ),
                },
              ),
              dateTime: utcLaunchDate.subtract(Duration(days: 1)),
            );
          }

          // T-1 hour notification
          if (utcCurrentDate.add(Duration(hours: 1)).isBefore(utcLaunchDate)) {
            await scheduleNotification(
              id: 1,
              title: translate(
                context,
                'spacex.notifications.launches.title',
              ),
              body: translate(
                context,
                'spacex.notifications.launches.body',
                translationParams: {
                  'rocket': nextLaunch.rocket.name,
                  'payload': nextLaunch.rocket.getSinglePayload.name,
                  'orbit': nextLaunch.rocket.getSinglePayload.orbit,
                  'time': translate(
                    context,
                    'spacex.notifications.launches.time_hour',
                  ),
                },
              ),
              dateTime: utcLaunchDate.subtract(Duration(hours: 1)),
            );
          }

          // T-30 minutes notification
          if (utcCurrentDate.add(Duration(minutes: 30)).isBefore(
                utcLaunchDate,
              )) {
            await scheduleNotification(
              id: 2,
              title: translate(
                context,
                'spacex.notifications.launches.title',
              ),
              body: translate(
                context,
                'spacex.notifications.launches.body',
                translationParams: {
                  'rocket': nextLaunch.rocket.name,
                  'payload': nextLaunch.rocket.getSinglePayload.name,
                  'orbit': nextLaunch.rocket.getSinglePayload.orbit,
                  'time': translate(
                    context,
                    'spacex.notifications.launches.time_minutes',
                    translationParams: {
                      'minutes': '30',
                    },
                  ),
                },
              ),
              dateTime: utcLaunchDate.subtract(Duration(minutes: 30)),
            );
          }

          await setNextLaunchDate(nextLaunch.launchDate);
        } else {
          await resetNextLaunchDate();
        }
      }
    } catch (_) {}
  }
}
