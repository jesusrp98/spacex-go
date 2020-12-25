import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../repositories/index.dart';

/// Serves as a way to communicate with the notification system.
class NotificationsProvider with ChangeNotifier {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static final _notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'channel.launches',
      'Launches notifications',
      'Stay up-to-date with upcoming SpaceX launches',
      importance: Importance.high,
    ),
    iOS: IOSNotificationDetails(),
  );

  /// Initializes the notifications system
  Future<void> init() async {
    try {
      await _notifications.initialize(InitializationSettings(
        android: AndroidInitializationSettings('notification_launch'),
        iOS: IOSInitializationSettings(),
      ));
    } catch (_) {}
  }

  /// Cancels all pending notifications
  static Future<void> cancelAllNotifications() async =>
      _notifications.cancelAll();

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
  static Future<void> scheduleNotifications(
    BuildContext context, {
    String title,
    DateTime date,
    String timeZone,
    List notifications,
  }) async {
    tz.initializeTimeZones();
    for (final notification in notifications) {
      await _notifications.zonedSchedule(
        notifications.indexOf(notification),
        title,
        notification['subtitle'],
        tz.TZDateTime.from(date, tz.getLocation(timeZone)).subtract(
          notification['subtract'],
        ),
        _notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
      );
    }
  }

  static Future<void> updateNotifications(BuildContext context) async {
    final nextLaunch = context.watch<LaunchesRepository>().upcomingLaunch;
    final localLaunchDate = nextLaunch?.localLaunchDate;

    try {
      final localTimeZone = await FlutterNativeTimezone.getLocalTimezone();
      if (nextLaunch != null) {
        if (await needsToUpdate(nextLaunch.launchDate)) {
          cancelAllNotifications();

          if (nextLaunch.launchDate != null) {
            await scheduleNotifications(
              context,
              title: FlutterI18n.translate(
                context,
                'spacex.notifications.launches.title',
              ),
              date: localLaunchDate,
              timeZone: localTimeZone,
              notifications: [
                // // T - 1 day notification
                {
                  'subtitle': FlutterI18n.translate(
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
                  'subtract': Duration(days: 1),
                },
                // // T - 1 hour notification
                {
                  'subtitle': FlutterI18n.translate(
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
                  'subtract': Duration(hours: 1),
                },
                // // T - 30 minutos notification
                {
                  'subtitle': FlutterI18n.translate(
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
                  'subtract': Duration(minutes: 30),
                },
              ],
            );
          }

          // Update storaged launch date
          await setNextLaunchDate(nextLaunch.launchDate);
        }
      }
    } catch (_) {}
  }
}
