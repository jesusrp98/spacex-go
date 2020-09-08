import 'package:cherry/models/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ShipVehicle', () {
    test('is correctly generated from a JSON', () {
      expect(
        ShipVehicle.fromJson(const {
          'model': 'Boat',
          'type': 'High Speed Craft',
          'roles': ['Fairing Recovery'],
          'mass_kg': 449964,
          'year_built': 2015,
          'home_port': 'Port Canaveral',
          'status': 'status',
          'speed_kn': 200,
          'latitude': 1.1,
          'longitude': 1.2,
          'link':
              'https://www.marinetraffic.com/en/ais/details/ships/shipid:3439091/mmsi:368099550/imo:9744465/vessel:GO_MS_TREE',
          'image': 'https://i.imgur.com/MtEgYbY.jpg',
          'launches': [
            {
              'flight_number': 50,
              'name': 'KoreaSat 5A',
              'id': '5eb87d0dffd86e000604b35b'
            }
          ],
          'name': 'GO Ms Tree',
          'active': true,
          'id': '5ea6ed2e080df4000697c908'
        }),
        ShipVehicle(
          id: '5ea6ed2e080df4000697c908',
          name: 'GO Ms Tree',
          url:
              'https://www.marinetraffic.com/en/ais/details/ships/shipid:3439091/mmsi:368099550/imo:9744465/vessel:GO_MS_TREE',
          mass: 449964,
          active: true,
          firstFlight: DateTime(2015),
          photos: const [
            'https://i.imgur.com/MtEgYbY.jpg',
          ],
          model: 'Boat',
          use: 'High Speed Craft',
          roles: const [
            'Fairing Recovery',
          ],
          missions: const [
            LaunchDetails(
              flightNumber: 50,
              name: 'KoreaSat 5A',
              id: '5eb87d0dffd86e000604b35b',
            )
          ],
          homePort: 'Port Canaveral',
          status: 'status',
          speed: 200,
          coordinates: const [1.1, 1.2],
        ),
      );
    });
  });
}
