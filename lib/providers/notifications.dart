import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/index.dart';

/// Serves as a way to communicate with the notification system.
class NotificationsProvider with ChangeNotifier {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static final _notificationDetails = NotificationDetails(
    AndroidNotificationDetails(
      'channel.launches',
      'Launches notifications',
      'Stay up-to-date with upcoming SpaceX launches',
      importance: Importance.High,
    ),
    IOSNotificationDetails(),
  );

  NotificationsProvider() {
    init();
  }

  /// Initializes the notifications system
  Future<void> init() async {
    await _notifications.initialize(InitializationSettings(
      AndroidInitializationSettings('notification_launch'),
      IOSInitializationSettings(),
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
    DateTime date,
    List notifications,
  }) async {
    for (final notification in notifications) {
      await _notifications.schedule(
        notifications.indexOf(notification),
        title,
        notification['subtitle'],
        date.subtract(notification['subtract']),
        _notificationDetails,
        androidAllowWhileIdle: true,
      );
    }
  }

  static Future<void> updateNotifications(BuildContext context) async {
    final nextLaunch = context.watch<LaunchesRepository>().upcomingLaunch;
    final localLaunchDate = nextLaunch.launchDate?.toLocal();

    if (nextLaunch != null) {
      if (await needsToUpdate(localLaunchDate)) {
        cancelAllNotifications();

        if (localLaunchDate != null) {
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
        await setNextLaunchDate(localLaunchDate);
      }
    }
  }
}
