import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsProvider with ChangeNotifier {
  final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();

  NotificationsProvider() {
    init();
  }

  Future<void> init() async {
    await notifications.initialize(const InitializationSettings(
      AndroidInitializationSettings('notification_launch'),
      IOSInitializationSettings(),
    ));

    notifyListeners();
  }
}
