import 'package:cherry/providers/index.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockFlutterLocalNotificationsPlugin extends Mock
    implements FlutterLocalNotificationsPlugin {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('NotificationsProvider', () {
    NotificationsProvider provider;

    setUp(() {
      provider = NotificationsProvider(
        MockFlutterLocalNotificationsPlugin(),
      );
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
        final SharedPreferences prefs = await SharedPreferences.getInstance();

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
      });
    });

    group('scheduling notifications', () {
      test('successfully schedule a notification', () async {});
    });
  });
}
