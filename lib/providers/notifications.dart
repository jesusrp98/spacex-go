import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Serves as a way to communicate with the notification system.
class NotificationsProvider with ChangeNotifier {
  final _notifications = FlutterLocalNotificationsPlugin();

  final _notificationDetails = NotificationDetails(
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
  Future<void> cancelAll() async => _notifications.cancelAll();

  Future<void> setNextLaunchDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
      'notifications.launches.upcoming',
      date.toIso8601String(),
    );
  }

  /// Checks if it's necceasry to update scheduled notifications
  Future<bool> needsToUpdate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getString('notifications.launches.upcoming') !=
          date.toIso8601String();
    } catch (_) {
      return true;
    }
  }

  /// Schedule new notifications
  Future<void> scheduleNotifications(
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
}
