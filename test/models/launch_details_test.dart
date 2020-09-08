import 'package:cherry/models/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LaunchDetails', () {
    test('is correctly generated from a JSON', () {
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
  });
}
