import 'package:cherry/models/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Crew', () {
    test('is correctly generated from a JSON', () {
      expect(
        Crew.fromJson(const {
          "name": "Douglas Hurley",
          "agency": "NASA",
          "image": "https://i.imgur.com/ooaayWf.png",
          "wikipedia": "https://en.wikipedia.org/wiki/Douglas_G._Hurley",
          "launches": [
            {
              "flight_number": 94,
              "name": "CCtCap Demo Mission 2",
              "date_utc": "2015-06-28T14:21:00.000Z",
              "id": "5eb87d46ffd86e000604b388"
            }
          ],
          "status": "active",
          "id": "5ebf1b7323a9a60006e03a7b"
        }),
        Crew(
          name: 'Douglas Hurley',
          agency: 'NASA',
          imageUrl: 'https://i.imgur.com/ooaayWf.png',
          wikipediaUrl: 'https://en.wikipedia.org/wiki/Douglas_G._Hurley',
          launches: [
            LaunchDetails(
              flightNumber: 94,
              name: 'CCtCap Demo Mission 2',
              date: DateTime.parse('2015-06-28T14:21:00.000Z'),
              id: '5eb87d46ffd86e000604b388',
            ),
          ],
          status: 'active',
          id: '5ebf1b7323a9a60006e03a7b',
        ),
      );
    });
  });
}
