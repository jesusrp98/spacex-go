import 'package:cherry/models/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LaunchDetails', () {
    test('is correctly generated from a JSON with date', () {
      expect(
        LaunchDetails.fromJson(const {
          'flight_number': 10,
          'name': 'CRS-2',
          'date_utc': '2015-06-28T14:21:00.000Z',
          'id': '5eb87ce1ffd86e000604b333'
        }),
        LaunchDetails(
          flightNumber: 10,
          name: 'CRS-2',
          date: DateTime.parse('2015-06-28T14:21:00.000Z'),
          id: '5eb87ce1ffd86e000604b333',
        ),
      );
    });

    test('is correctly generated from a JSON with date', () {
      expect(
        LaunchDetails.fromJson(const {
          'flight_number': 10,
          'name': 'CRS-2',
          'id': '5eb87ce1ffd86e000604b333'
        }),
        LaunchDetails(
          flightNumber: 10,
          name: 'CRS-2',
          id: '5eb87ce1ffd86e000604b333',
        ),
      );
    });

    test('correctly returns local date', () {
      final date = DateTime.now();
      expect(
        LaunchDetails(date: date).localDate,
        date,
      );
    });
  });
}
