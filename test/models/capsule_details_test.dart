import 'package:cherry/models/index.dart';
import 'package:flutter_test/flutter_test.dart';

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
          id: '5e9e2c5bf359189ef23b2667',
        ),
      );
    });
  });
}
