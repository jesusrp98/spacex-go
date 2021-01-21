import 'package:cherry/cubits/index.dart';
import 'package:cherry/models/index.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:platform/platform.dart';

import 'helpers/hydrated.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  initHydratedBloc();
  group('NotificationsCubit', () {
    const channel = MethodChannel('dexterous.com/flutter/local_notifications');
    final log = <MethodCall>[];

    NotificationsCubit cubit;
    FlutterLocalNotificationsPlugin service;
    MockBuildContext context;
    DateTime currentDateTime;

    setUp(() {
      tz.initializeTimeZones();

      currentDateTime = DateTime.now().toUtc();

      context = MockBuildContext();

      service = FlutterLocalNotificationsPlugin.private(
        FakePlatform(operatingSystem: 'ios'),
      );

      channel.setMockMethodCallHandler((methodCall) {
        log.add(methodCall);
        if (methodCall.method == 'pendingNotificationRequests') {
          return Future<List<Map<String, Object>>>.value([]);
        } else if (methodCall.method == 'getNotificationAppLaunchDetails') {
          return Future<Map<String, Object>>.value({});
        }
        return Future<void>.value();
      });

      cubit = NotificationsCubit(
        service,
        notificationDetails: NotificationDetails(),
        initializationSettings: InitializationSettings(),
      );
    });

    tearDown(() {
      log.clear();
    });

    group('testing arguments & init', () {
      test('checks if service is null', () {
        expect(() => NotificationsCubit(null), throwsAssertionError);
      });

      test('checks notifications initialization', () async {
        await cubit.init();
      });
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        expect(
          cubit.fromJson(cubit.toJson(cubit.state)),
          cubit.state,
        );
      });
    });

    group('testing date saving', () {
      test('saves new launch date', () {
        cubit.setNextLaunchDate(DateTime(1970));
        expect(cubit.state, DateTime(1970));
      });

      test('checks current launch date', () {
        cubit.setNextLaunchDate(DateTime(1970));
        expect(cubit.needsToUpdate(DateTime(1971)), true);
        expect(cubit.needsToUpdate(DateTime(1970)), false);

        cubit.setNextLaunchDate(null);
        expect(cubit.needsToUpdate(DateTime(1970)), true);
        expect(cubit.needsToUpdate(DateTime(1971)), true);
      });
    });

    group('scheduling notifications', () {
      test(
        "correctly checks that the launch date is not concrete enough",
        () async {
          await cubit.updateNotifications(
            MockBuildContext(),
            nextLaunch: _getMockLaunch(
              launchDate: currentDateTime.add(Duration(days: 5)),
              datePrecision: 'day',
            ),
          );

          expect(cubit.state, null);
          expect(log.length, isZero);
        },
      );

      test(
        "correctly deletes previous notifications, but launch date is not concrete enough",
        () async {
          cubit.setNextLaunchDate(DateTime(1970));

          await cubit.updateNotifications(
            MockBuildContext(),
            nextLaunch: _getMockLaunch(
              launchDate: currentDateTime.add(Duration(days: 5)),
              datePrecision: 'day',
            ),
          );

          expect(cubit.state, null);
          expect(log.length, 1);
          expect(log[0], isMethodCall('cancelAll', arguments: null));
        },
      );

      test(
        "correctly adds the 30-mins notification to the system",
        () async {
          await cubit.updateNotifications(
            context,
            nextLaunch: _getMockLaunch(
              launchDate: currentDateTime.add(Duration(minutes: 31)),
              datePrecision: 'hour',
            ),
          );

          expect(cubit.state, currentDateTime.add(Duration(minutes: 31)));
          expect(log.length, 1);
          expect(
            log[0],
            isMethodCall(
              'zonedSchedule',
              arguments: <String, Object>{
                'id': 2,
                'title': 'spacex.notifications.launches.title',
                'body': 'spacex.notifications.launches.body',
                'platformSpecifics': <String, Object>{},
                'payload': '',
                'uiLocalNotificationDateInterpretation': 1,
                'timeZoneName': 'UTC',
                'scheduledDateTime': _convertDateToISO8601String(
                  tz.TZDateTime.from(
                    currentDateTime.add(Duration(minutes: 31)),
                    tz.UTC,
                  ).subtract(Duration(minutes: 30)),
                ),
              },
            ),
          );
        },
      );

      test(
        "correctly adds the 30-mins and 1-hour notifications to the system",
        () async {
          await cubit.updateNotifications(
            context,
            nextLaunch: _getMockLaunch(
              launchDate: currentDateTime.add(Duration(hours: 2)),
              datePrecision: 'hour',
            ),
          );

          expect(cubit.state, currentDateTime.add(Duration(hours: 2)));
          expect(log.length, 2);
          expect(
            log[0],
            isMethodCall(
              'zonedSchedule',
              arguments: <String, Object>{
                'id': 1,
                'title': 'spacex.notifications.launches.title',
                'body': 'spacex.notifications.launches.body',
                'platformSpecifics': <String, Object>{},
                'payload': '',
                'uiLocalNotificationDateInterpretation': 1,
                'timeZoneName': 'UTC',
                'scheduledDateTime': _convertDateToISO8601String(
                  tz.TZDateTime.from(
                    currentDateTime.add(Duration(hours: 2)),
                    tz.UTC,
                  ).subtract(Duration(hours: 1)),
                ),
              },
            ),
          );
          expect(
            log[1],
            isMethodCall(
              'zonedSchedule',
              arguments: <String, Object>{
                'id': 2,
                'title': 'spacex.notifications.launches.title',
                'body': 'spacex.notifications.launches.body',
                'platformSpecifics': <String, Object>{},
                'payload': '',
                'uiLocalNotificationDateInterpretation': 1,
                'timeZoneName': 'UTC',
                'scheduledDateTime': _convertDateToISO8601String(
                  tz.TZDateTime.from(
                    currentDateTime.add(Duration(hours: 2)),
                    tz.UTC,
                  ).subtract(Duration(minutes: 30)),
                ),
              },
            ),
          );
        },
      );

      test(
        "correctly update all notifications with no previous notifications",
        () async {
          await cubit.updateNotifications(
            context,
            nextLaunch: _getMockLaunch(
              launchDate: currentDateTime.add(Duration(days: 5)),
              datePrecision: 'hour',
            ),
          );

          expect(cubit.state, currentDateTime.add(Duration(days: 5)));
          expect(log.length, 3);
          expect(
            log[0],
            isMethodCall(
              'zonedSchedule',
              arguments: <String, Object>{
                'id': 0,
                'title': 'spacex.notifications.launches.title',
                'body': 'spacex.notifications.launches.body',
                'platformSpecifics': <String, Object>{},
                'payload': '',
                'uiLocalNotificationDateInterpretation': 1,
                'timeZoneName': 'UTC',
                'scheduledDateTime': _convertDateToISO8601String(
                  tz.TZDateTime.from(
                    currentDateTime.add(Duration(days: 5)),
                    tz.UTC,
                  ).subtract(Duration(days: 1)),
                ),
              },
            ),
          );
          expect(
            log[1],
            isMethodCall(
              'zonedSchedule',
              arguments: <String, Object>{
                'id': 1,
                'title': 'spacex.notifications.launches.title',
                'body': 'spacex.notifications.launches.body',
                'platformSpecifics': <String, Object>{},
                'payload': '',
                'uiLocalNotificationDateInterpretation': 1,
                'timeZoneName': 'UTC',
                'scheduledDateTime': _convertDateToISO8601String(
                  tz.TZDateTime.from(
                    currentDateTime.add(Duration(days: 5)),
                    tz.UTC,
                  ).subtract(Duration(hours: 1)),
                ),
              },
            ),
          );
          expect(
            log[2],
            isMethodCall(
              'zonedSchedule',
              arguments: <String, Object>{
                'id': 2,
                'title': 'spacex.notifications.launches.title',
                'body': 'spacex.notifications.launches.body',
                'platformSpecifics': <String, Object>{},
                'payload': '',
                'uiLocalNotificationDateInterpretation': 1,
                'timeZoneName': 'UTC',
                'scheduledDateTime': _convertDateToISO8601String(
                  tz.TZDateTime.from(
                    currentDateTime.add(Duration(days: 5)),
                    tz.UTC,
                  ).subtract(Duration(minutes: 30)),
                ),
              },
            ),
          );
        },
      );
    });
  });
}

Launch _getMockLaunch({DateTime launchDate, String datePrecision}) {
  return Launch(
    launchDate: launchDate,
    datePrecision: datePrecision,
    rocket: RocketDetails(
      name: 'RocketName',
      payloads: const [
        Payload(
          name: 'PayloadName',
          orbit: 'PayloadOrbit',
        )
      ],
    ),
  );
}

String _convertDateToISO8601String(tz.TZDateTime dateTime) {
  String _twoDigits(int n) {
    if (n >= 10) {
      return '$n';
    }
    return '0$n';
  }

  String _fourDigits(int n) {
    final int absN = n.abs();
    final String sign = n < 0 ? '-' : '';
    if (absN >= 1000) {
      return '$n';
    }
    if (absN >= 100) {
      return '${sign}0$absN';
    }
    if (absN >= 10) {
      return '${sign}00$absN';
    }
    return '${sign}000$absN';
  }

  return '${_fourDigits(dateTime.year)}-${_twoDigits(dateTime.month)}-${_twoDigits(dateTime.day)}T${_twoDigits(dateTime.hour)}:${_twoDigits(dateTime.minute)}:${_twoDigits(dateTime.second)}'; // ignore: lines_longer_than_80_chars
}
