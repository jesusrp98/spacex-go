import 'package:cherry/models/index.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock_context.dart';

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
        ),
      );
    });

    test('correctly returns roles', () {
      expect(
        ShipVehicle(roles: const ['', '']).hasSeveralRoles,
        true,
      );
    });

    test('correctly returns primary role', () {
      expect(
        ShipVehicle(roles: const ['role']).primaryRole,
        'role',
      );
    });

    test('correctly returns primary role', () {
      expect(
        ShipVehicle(roles: const ['role', 'role2']).secondaryRole,
        'role2',
      );
    });

    test('correctly check mission number', () {
      expect(
        ShipVehicle(missions: const []).hasMissions,
        false,
      );
    });

    test('correctly returns built date', () {
      expect(
        ShipVehicle(firstFlight: DateTime(2015)).getBuiltFullDate,
        '2015',
      );
    });

    test('correctly returns subtitle', () {
      expect(
        ShipVehicle(firstFlight: DateTime(2015)).subtitle(MockBuildContext()),
        'spacex.vehicle.subtitle.ship_built',
      );
    });

    test('correctly returns subtitle', () {
      expect(
        ShipVehicle().getModel(MockBuildContext()),
        'spacex.other.unknown',
      );

      expect(
        ShipVehicle(model: 'Lorem').getModel(MockBuildContext()),
        'Lorem',
      );
    });

    test('correctly returns status', () {
      expect(
        ShipVehicle().getStatus(MockBuildContext()),
        'spacex.other.unknown',
      );

      expect(
        ShipVehicle(status: 'Lorem').getStatus(MockBuildContext()),
        'Lorem',
      );
    });

    test('correctly returns speed', () {
      expect(
        ShipVehicle().getSpeed(MockBuildContext()),
        'spacex.other.unknown',
      );

      expect(
        ShipVehicle(speed: 100).getSpeed(MockBuildContext()),
        '185.2 km/h',
      );
    });

    test('correctly returns mass', () {
      expect(
        ShipVehicle().getMass(MockBuildContext()),
        'spacex.other.unknown',
      );

      expect(
        ShipVehicle(mass: 100).getMass(MockBuildContext()),
        '100 kg',
      );
    });
  });
}
