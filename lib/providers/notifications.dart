import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
    await _notifications.initialize(InitializationSettings(
      android: AndroidInitializationSettings('notification_launch'),
      iOS: IOSInitializationSettings(),
    ));
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
    tz.TZDateTime date,
    List notifications,
  }) async {
    tz.initializeTimeZones();
    for (final notification in notifications) {
      await _notifications.zonedSchedule(
        notifications.indexOf(notification),
        title,
        notification['subtitle'],
        date,
        _notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
      );
    }
  }

  static Future<void> updateNotifications(BuildContext context) async {
    final tz.TZDateTime localLaunchDate =
        tz.TZDateTime.now(tz.UTC).add(const Duration(seconds: 5));
    await scheduleNotifications(
      context,
      title: FlutterI18n.translate(
        context,
        'spacex.notifications.launches.title',
      ),
      date: localLaunchDate,
      notifications: [
        // // T - 1 day notification
        {
          'subtitle': FlutterI18n.translate(
            context,
            'spacex.notifications.launches.body',
            translationParams: {
              'rocket': 'nextLaunch.rocket.name',
              'payload': 'nextLaunch.rocket.getSinglePayload.name',
              'orbit': 'nextLaunch.rocket.getSinglePayload.orbit',
              'time': FlutterI18n.translate(
                context,
                'spacex.notifications.launches.time_tomorrow',
              ),
            },
          ),
          'subtract': Duration(days: 1),
        },
      ],
    );
  }
}
