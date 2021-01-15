import 'package:cherry/models/index.dart';
import 'package:intl/intl.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock_context.dart';

void main() {
  group('CapsuleDetails', () {
    test('is correctly generated from a JSON', () {
      expect(
        CapsuleDetails.fromJson(const {
          'reuse_count': 1,
          'water_landings': 1,
          'last_update': 'descripction',
          'launches': [
            {
              'flight_number': 10,
              'name': 'CRS-2',
              "date_utc": "2015-06-28T14:21:00.000Z",
              'id': '5eb87ce1ffd86e000604b333'
            }
          ],
          'serial': 'C104',
          'status': 'unknown',
          "type": "Dragon 1.0",
          'id': '5e9e2c5bf359189ef23b2667'
        }),
        CapsuleDetails(
          reuseCount: 1,
          splashings: 1,
          lastUpdate: 'descripction',
          launches: [
            LaunchDetails(
              flightNumber: 10,
              name: 'CRS-2',
              date: DateTime.parse('2015-06-28T14:21:00.000Z'),
              id: '5eb87ce1ffd86e000604b333',
            )
          ],
          serial: 'C104',
          status: 'unknown',
          type: 'Dragon 1.0',
          id: '5e9e2c5bf359189ef23b2667',
        ),
      );
    });

    test('correctly returns first launch data', () {
      expect(
        CapsuleDetails(launches: const []).getFirstLaunched(MockBuildContext()),
        'spacex.other.unknown',
      );

      expect(
        CapsuleDetails(
          launches: [LaunchDetails(date: DateTime.now())],
        ).getFirstLaunched(MockBuildContext()),
        DateFormat.yMMMMd().format(DateTime.now().toLocal()),
      );
    });

    test('correctly returns details', () {
      expect(
        CapsuleDetails().getDetails(MockBuildContext()),
        'spacex.dialog.vehicle.no_description_capsule',
      );

      expect(
        CapsuleDetails(lastUpdate: 'Lorem').getDetails(MockBuildContext()),
        'Lorem',
      );
    });

    test('correctly returns parsed status', () {
      expect(
        CapsuleDetails(status: 'test').getStatus,
        'Test',
      );
    });

    test('correctly returns splashing number', () {
      expect(
        CapsuleDetails(splashings: 2).getSplashings,
        '2',
      );
    });

    test('correctly returns launch number', () {
      expect(
        CapsuleDetails(launches: const [
          LaunchDetails(),
          LaunchDetails(),
        ]).getLaunches,
        '2',
      );
    });

    test('correctly check mission number', () {
      expect(
        CapsuleDetails(launches: const []).hasMissions,
        false,
      );
    });
  });
}
