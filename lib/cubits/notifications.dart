import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../models/index.dart';
import '../utils/index.dart';

/// Serves as a way to communicate with the notification system.
class NotificationsCubit extends HydratedCubit<DateTime> {
  final FlutterLocalNotificationsPlugin service;
  final NotificationDetails notificationDetails;
  final InitializationSettings initializationSettings;

  NotificationsCubit(
    this.service, {
    this.notificationDetails,
    this.initializationSettings,
  })  : assert(service != null),
        super(null);

  /// Initializes the notifications system
  Future<void> init() async {
    try {
      await service.initialize(initializationSettings);
    } catch (_) {}
  }

  /// Saves the current target launch date
  void setNextLaunchDate(DateTime date) => emit(date);

  /// Clears previous set notifications if they exist
  void clearPreviousNotifications() {
    if (state != null) {
      service.cancelAll();
    }
  }

  /// Sets the target launch date to null
  void resetNextLaunchDate() => emit(null);

  /// Checks if it's necceasry to update scheduled notifications
  bool needsToUpdate(DateTime date) => state != date;

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

  /// Method that handle the schedule of launch notifications over the time
  Future<void> updateNotifications(
    BuildContext context, {
    @required Launch nextLaunch,
  }) async {
    try {
      if (nextLaunch != null && needsToUpdate(nextLaunch.launchDate)) {
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
              title: context.translate(
                'spacex.notifications.launches.title',
              ),
              body: context.translate(
                'spacex.notifications.launches.body',
                parameters: {
                  'rocket': nextLaunch.rocket.name,
                  'payload': nextLaunch.rocket.getSinglePayload.name,
                  'orbit': nextLaunch.rocket.getSinglePayload.orbit,
                  'time': context.translate(
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
              title: context.translate(
                'spacex.notifications.launches.title',
              ),
              body: context.translate(
                'spacex.notifications.launches.body',
                parameters: {
                  'rocket': nextLaunch.rocket.name,
                  'payload': nextLaunch.rocket.getSinglePayload.name,
                  'orbit': nextLaunch.rocket.getSinglePayload.orbit,
                  'time': context.translate(
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
              title: context.translate(
                'spacex.notifications.launches.title',
              ),
              body: context.translate(
                'spacex.notifications.launches.body',
                parameters: {
                  'rocket': nextLaunch.rocket.name,
                  'payload': nextLaunch.rocket.getSinglePayload.name,
                  'orbit': nextLaunch.rocket.getSinglePayload.orbit,
                  'time': context.translate(
                    'spacex.notifications.launches.time_minutes',
                    parameters: {
                      'minutes': '30',
                    },
                  ),
                },
              ),
              dateTime: utcLaunchDate.subtract(Duration(minutes: 30)),
            );
          }

          setNextLaunchDate(nextLaunch.launchDate);
        } else {
          resetNextLaunchDate();
        }
      }
    } catch (_) {}
  }

  @override
  DateTime fromJson(Map<String, dynamic> json) {
    return json['value'] != null ? DateTime.tryParse(json['value']) : null;
  }

  @override
  Map<String, String> toJson(DateTime state) {
    return {
      'value': state?.toIso8601String(),
    };
  }
}
