import 'package:cherry/models/index.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock_context.dart';

void main() {
  group('Payload', () {
    test('is correctly generated from a JSON', () {
      expect(
        Payload.fromJson(const {
          "dragon": {
            "capsule": {
              "reuse_count": 1,
              "water_landings": 1,
              "last_update": "descripction",
              "launches": [
                {
                  "flight_number": 10,
                  "name": "CRS-2",
                  "date_utc": "2015-06-28T14:21:00.000Z",
                  "id": "5eb87ce1ffd86e000604b333"
                }
              ],
              "serial": "C104",
              "status": "unknown",
              "type": "Dragon 1.0",
              "id": "5e9e2c5bf359189ef23b2667"
            }
          },
          "name": "FalconSAT-2",
          "reused": true,
          "customers": ["DARPA"],
          "nationalities": ["United States"],
          "manufacturers": ["SSTL"],
          "mass_kg": 20,
          "orbit": "LEO",
          "periapsis_km": 400,
          "apoapsis_km": 500,
          "inclination_deg": 39,
          "period_min": 90.0,
          "id": "5eb0e4b5b6c3bb0006eeb1e1"
        }),
        Payload(
          capsule: CapsuleDetails(
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
          name: 'FalconSAT-2',
          reused: true,
          customer: 'DARPA',
          nationality: 'United States',
          manufacturer: 'SSTL',
          mass: 20,
          orbit: 'LEO',
          periapsis: 400,
          apoapsis: 500,
          inclination: 39,
          period: 90.0,
          id: '5eb0e4b5b6c3bb0006eeb1e1',
        ),
      );
    });

    test('correctly checks name', () {
      expect(
        Payload().getName(MockBuildContext()),
        'spacex.other.unknown',
      );
      expect(
        Payload(name: 'Lorem').getName(MockBuildContext()),
        'Lorem',
      );
    });

    test('correctly checks customer', () {
      expect(
        Payload().getCustomer(MockBuildContext()),
        'spacex.other.unknown',
      );
      expect(
        Payload(customer: 'Lorem').getCustomer(MockBuildContext()),
        'Lorem',
      );
    });

    test('correctly checks nationality', () {
      expect(
        Payload().getNationality(MockBuildContext()),
        'spacex.other.unknown',
      );
      expect(
        Payload(nationality: 'Lorem').getNationality(MockBuildContext()),
        'Lorem',
      );
    });

    test('correctly checks manufacturer', () {
      expect(
        Payload().getManufacturer(MockBuildContext()),
        'spacex.other.unknown',
      );
      expect(
        Payload(manufacturer: 'Lorem').getManufacturer(MockBuildContext()),
        'Lorem',
      );
    });

    test('correctly checks orbit', () {
      expect(
        Payload().getOrbit(MockBuildContext()),
        'spacex.other.unknown',
      );
      expect(
        Payload(orbit: 'Lorem').getOrbit(MockBuildContext()),
        'Lorem',
      );
    });

    test('correctly checks mass', () {
      expect(
        Payload().getMass(MockBuildContext()),
        'spacex.other.unknown',
      );
      expect(
        Payload(mass: 100).getMass(MockBuildContext()),
        '100 kg',
      );
    });

    test('correctly checks periapsis', () {
      expect(
        Payload().getPeriapsis(MockBuildContext()),
        'spacex.other.unknown',
      );
      expect(
        Payload(periapsis: 100).getPeriapsis(MockBuildContext()),
        '100 km',
      );
    });

    test('correctly checks apoapsis', () {
      expect(
        Payload().getApoapsis(MockBuildContext()),
        'spacex.other.unknown',
      );
      expect(
        Payload(apoapsis: 100).getApoapsis(MockBuildContext()),
        '100 km',
      );
    });

    test('correctly checks inclination', () {
      expect(
        Payload().getInclination(MockBuildContext()),
        'spacex.other.unknown',
      );
      expect(
        Payload(inclination: 100).getInclination(MockBuildContext()),
        '100°',
      );
    });

    test('correctly checks period', () {
      expect(
        Payload().getPeriod(MockBuildContext()),
        'spacex.other.unknown',
      );
      expect(
        Payload(period: 100).getPeriod(MockBuildContext()),
        '100 min',
      );
    });

    test('correctly checks for NASA payload', () {
      expect(
        Payload(customer: 'NASA (CCtCap)').isNasaPayload,
        true,
      );
      expect(
        Payload(customer: 'NASA (CRS)').isNasaPayload,
        true,
      );
      expect(
        Payload(customer: 'NASA(COTS)').isNasaPayload,
        true,
      );
    });
  });
}
