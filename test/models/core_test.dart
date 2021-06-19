import 'package:cherry/models/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import 'mock_context.dart';

void main() {
  group('Core', () {
    test('is correctly generated from a JSON', () {
      expect(
        Core.fromJson(const {
          "core": {
            "block": 5,
            "reuse_count": 0,
            "rtls_attempts": 0,
            "rtls_landings": 0,
            "asds_attempts": 0,
            "asds_landings": 0,
            "last_update":
                "Engine failure at T+33 seconds resulted in loss of vehicle",
            "launches": [
              {
                "flight_number": 1,
                "name": "FalconSat",
                "date_utc": "2015-06-28T14:21:00.000Z",
                "id": "5eb87cd9ffd86e000604b32a"
              }
            ],
            "serial": "Merlin1A",
            "status": "lost",
            "id": "5e9e289df35918033d3b2623"
          },
          "gridfins": false,
          "legs": false,
          "reused": false,
          "landing_attempt": false,
          "landing_success": false,
          "landpad": {
            'images': {
              'large': ['image.com']
            },
            "name": "OCISLY",
            "full_name": "Of Course I Still Love You",
            "type": "ASDS",
            "locality": "Port Canaveral",
            "region": "Florida",
            "latitude": 28.4104,
            "longitude": -80.6188,
            "landing_attempts": 36,
            "landing_successes": 30,
            "wikipedia":
                "https://en.wikipedia.org/wiki/Autonomous_spaceport_drone_ship",
            "details":
                "The second ASDS barge, Of Course I Still Love You (OCISLY), had been under construction in a Louisiana shipyard since early 2015 using a different hull—Marmac 304—in order to service launches on the east coast. It was built as a replacement for the first Just Read the Instructions and entered operational service for Falcon 9 Flight 19 in late June 2015. As of June 2015, its home port was Jacksonville, Florida, but after December 2015, it was transferred 160 miles (260 km) further south, at Port Canaveral. While the dimensions of the ship are nearly identical to the first ASDS, several enhancements were made including a steel blast wall erected between the aft containers and the landing deck. The ship was in place for a first-stage landing test on the CRS-7 mission, which failed on launch on 28 June 2015. On 8 April 2016 the first stage, which launched the Dragon CRS-8 spacecraft, successfully landed for the first time ever on OCISLY, which is also the first ever drone ship landing. In February 2018, the Falcon Heavy Test Flight's central core exploded upon impact next to OCISLY that damaged two of the four thrusters on the drone ship. Two thrusters were removed from the Marmac 303 barge in order to repair OCISLY.",
            "status": "active",
            "id": "5e9e3032383ecb6bb234e7ca"
          }
        }),
        Core(
          block: 5,
          reuseCount: 0,
          rtlsAttempts: 0,
          rtlsLandings: 0,
          asdsAttempts: 0,
          asdsLandings: 0,
          lastUpdate:
              'Engine failure at T+33 seconds resulted in loss of vehicle',
          launches: [
            LaunchDetails(
              flightNumber: 1,
              name: 'FalconSat',
              date: DateTime.parse('2015-06-28T14:21:00.000Z'),
              id: '5eb87cd9ffd86e000604b32a',
            ),
          ],
          serial: 'Merlin1A',
          status: 'lost',
          id: '5e9e289df35918033d3b2623',
          hasGridfins: false,
          hasLegs: false,
          reused: false,
          landingAttempt: false,
          landingSuccess: false,
          landpad: LandpadDetails(
            name: 'OCISLY',
            fullName: 'Of Course I Still Love You',
            type: 'ASDS',
            locality: 'Port Canaveral',
            region: 'Florida',
            latitude: 28.4104,
            longitude: -80.6188,
            landingAttempts: 36,
            landingSuccesses: 30,
            wikipediaUrl:
                'https://en.wikipedia.org/wiki/Autonomous_spaceport_drone_ship',
            details:
                "The second ASDS barge, Of Course I Still Love You (OCISLY), had been under construction in a Louisiana shipyard since early 2015 using a different hull—Marmac 304—in order to service launches on the east coast. It was built as a replacement for the first Just Read the Instructions and entered operational service for Falcon 9 Flight 19 in late June 2015. As of June 2015, its home port was Jacksonville, Florida, but after December 2015, it was transferred 160 miles (260 km) further south, at Port Canaveral. While the dimensions of the ship are nearly identical to the first ASDS, several enhancements were made including a steel blast wall erected between the aft containers and the landing deck. The ship was in place for a first-stage landing test on the CRS-7 mission, which failed on launch on 28 June 2015. On 8 April 2016 the first stage, which launched the Dragon CRS-8 spacecraft, successfully landed for the first time ever on OCISLY, which is also the first ever drone ship landing. In February 2018, the Falcon Heavy Test Flight's central core exploded upon impact next to OCISLY that damaged two of the four thrusters on the drone ship. Two thrusters were removed from the Marmac 303 barge in order to repair OCISLY.",
            status: 'active',
            id: '5e9e3032383ecb6bb234e7ca',
          ),
        ),
      );
    });

    test('correctly returns first launch data', () {
      expect(
        Core(launches: const []).getFirstLaunched(MockBuildContext()),
        'spacex.other.unknown',
      );

      expect(
        Core(
          launches: [LaunchDetails(date: DateTime.now())],
        ).getFirstLaunched(MockBuildContext()),
        DateFormat.yMMMMd().format(DateTime.now().toLocal()),
      );
    });

    test('correctly returns details', () {
      expect(
        Core().getDetails(MockBuildContext()),
        'spacex.dialog.vehicle.no_description_core',
      );

      expect(
        Core(lastUpdate: 'Lorem').getDetails(MockBuildContext()),
        'Lorem',
      );
    });

    test('correctly returns block', () {
      expect(
        Core().getBlock(MockBuildContext()),
        'spacex.other.unknown',
      );

      expect(
        Core(block: 5).getBlock(MockBuildContext()),
        'spacex.other.block',
      );
    });

    test('correctly returns status', () {
      expect(
        Core(status: 'test').getStatus,
        'Test',
      );
    });

    test('correctly returns launch number', () {
      expect(
        Core(launches: const [
          LaunchDetails(),
          LaunchDetails(),
        ]).getLaunches,
        '2',
      );
    });

    test('correctly check mission number', () {
      expect(
        Core(launches: const []).hasMissions,
        false,
      );
    });

    test('correctly returns RTLS landings', () {
      expect(
        Core(rtlsAttempts: 10, rtlsLandings: 5).getRtlsLandings,
        '5/10',
      );
    });

    test('correctly returns ASDS landings', () {
      expect(
        Core(asdsAttempts: 10, asdsLandings: 5).getAsdsLandings,
        '5/10',
      );
    });
  });
}
