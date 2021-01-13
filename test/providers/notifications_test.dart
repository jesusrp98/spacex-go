import 'package:cherry/models/index.dart';
import 'package:cherry/providers/index.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:platform/platform.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('NotificationsProvider', () {
    const channel = MethodChannel('dexterous.com/flutter/local_notifications');
    final log = <MethodCall>[];

    NotificationsProvider provider;
    FlutterLocalNotificationsPlugin service;
    MockBuildContext context;
    DateTime currentDateTime;

    setUp(() {
      SharedPreferences.setMockInitialValues({});

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

      provider = NotificationsProvider(
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
        expect(() => NotificationsProvider(null), throwsAssertionError);
      });

      test('checks notifications initialization', () {
        provider.init();
      });
    });

    group('testing date saving', () {
      test('saves new launch date', () async {
        final prefs = await SharedPreferences.getInstance();

        await NotificationsProvider.setNextLaunchDate(DateTime(1970));
        expect(
          prefs.getString('notifications.launches.upcoming'),
          DateTime(1970).toIso8601String(),
        );
      });

      test('checks current launch date', () async {
        SharedPreferences.setMockInitialValues({
          'flutter.notifications.launches.upcoming':
              DateTime(1970).toIso8601String()
        });

        expect(
          await NotificationsProvider.needsToUpdate(DateTime(1971)),
          true,
        );
        expect(
          await NotificationsProvider.needsToUpdate(DateTime(1970)),
          false,
        );

        SharedPreferences.setMockInitialValues({});
        expect(
          await NotificationsProvider.needsToUpdate(DateTime(1971)),
          true,
        );
      });
    });

    group('scheduling notifications', () {
      test(
        "correctly checks that there's no previous notifications, but launch date is not concrete enough",
        () async {
          await provider.updateNotifications(
            MockBuildContext(),
            nextLaunch: _getMockLaunch(
              launchDate: currentDateTime.add(Duration(days: 5)),
              datePrecision: 'day',
            ),
          );

          final prefs = await SharedPreferences.getInstance();
          expect(prefs.getString('notifications.launches.upcoming'), null);

          expect(log.length, isZero);
        },
      );

      test(
        "correctly deletes previous notifications, but launch date is not concrete enough",
        () async {
          SharedPreferences.setMockInitialValues({
            'flutter.notifications.launches.upcoming':
                DateTime(1970).toIso8601String(),
          });

          await provider.updateNotifications(
            MockBuildContext(),
            nextLaunch: _getMockLaunch(
              launchDate: currentDateTime.add(Duration(days: 5)),
              datePrecision: 'day',
            ),
          );

          final prefs = await SharedPreferences.getInstance();
          expect(prefs.getString('notifications.launches.upcoming'), null);

          expect(log.length, 1);
        },
      );

      // TODO implementar control para cuando el lanzamiento es too early

      test(
        "correctly update notifications with no previous notifications",
        () async {
          await provider.updateNotifications(
            context,
            nextLaunch: _getMockLaunch(
              launchDate: currentDateTime.add(Duration(days: 5)),
              datePrecision: 'hour',
            ),
            location: tz.getLocation('Australia/Sydney'),
          );

          // debugPrint(log.toString());

          final prefs = await SharedPreferences.getInstance();
          expect(
            prefs.getString('notifications.launches.upcoming'),
            currentDateTime.add(Duration(days: 5)).toIso8601String(),
          );

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
                'timeZoneName': 'Australia/Sydney',
                'scheduledDateTime': _convertDateToISO8601String(
                  tz.TZDateTime.from(
                    currentDateTime.add(Duration(days: 5)),
                    tz.getLocation('Australia/Sydney'),
                  ),
                ),
              },
            ),
          );
        },
      );

      // test(
      //   "correctly checks that there's no need to update notifications",
      //   () async {
      //     SharedPreferences.setMockInitialValues({
      //       'flutter.notifications.launches.upcoming':
      //           DateTime(1970).toIso8601String()
      //     });
      //     await provider.updateNotifications(
      //       MockBuildContext(),
      //       nextLaunch: Launch(
      //         launchDate: DateTime(1970),
      //         datePrecision: 'hour',
      //       ),
      //     );

      //     final prefs = await SharedPreferences.getInstance();
      //     expect(
      //       prefs.getString('notifications.launches.upcoming'),
      //       DateTime(1970).toIso8601String(),
      //     );

      //     expect(log.length, 0);
      //   },
      // );

      // test(
      //   "correctly checks that the launch date precision is insufficient",
      //   () async {
      //     SharedPreferences.setMockInitialValues({
      //       'flutter.notifications.launches.upcoming':
      //           DateTime(1970).toIso8601String()
      //     });

      //     await provider.updateNotifications(
      //       MockBuildContext(),
      //       nextLaunch: Launch(
      //         launchDate: DateTime(1971),
      //         datePrecision: 'day',
      //       ),
      //     );

      //     final prefs = await SharedPreferences.getInstance();
      //     expect(prefs.getString('notifications.launches.upcoming'), null);

      //     expect(log.last, isMethodCall('cancelAll', arguments: null));
      //   },
      // );

      // test(
      //   "correctly update notifications with previous notifications",
      //   () async {
      //     SharedPreferences.setMockInitialValues({
      //       'flutter.notifications.launches.upcoming':
      //           DateTime(1970).toIso8601String()
      //     });

      //     final prefs = await SharedPreferences.getInstance();

      //     await provider.updateNotifications(
      //       MockBuildContext(),
      //       nextLaunch: Launch(
      //         launchDate: DateTime(1972),
      //         datePrecision: 'hour',
      //       ),
      //     );

      //     expect(
      //       prefs.getString('notifications.launches.upcoming'),
      //       DateTime(1972).toIso8601String(),
      //     );
      //   },
      // );
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
