import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// This provider is in charge of initializing the notification system.
class NotificationsProvider with ChangeNotifier {
  final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();

  NotificationsProvider() {
    init();
  }

  /// Initializes the notifications system
  Future<void> init() async {
    await notifications.initialize(const InitializationSettings(
      AndroidInitializationSettings('notification_launch'),
      IOSInitializationSettings(),
    ));

    notifyListeners();
  }
}
