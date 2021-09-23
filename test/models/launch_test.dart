import 'package:cherry/models/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import 'mock_context.dart';

void main() {
  group('Launch', () {
    test('is correctly generated from a JSON', () {
      expect(
        Launch.fromJson(const {
          "fairings": {
            "reused": true,
            "recovery_attempt": true,
            "recovered": true,
            "ships": [
              {"name": "GO Ms Tree", "id": "5ea6ed2e080df4000697c908"}
            ]
          },
          "links": {
            "patch": {
              "small": "https://images2.imgbox.com/3c/0e/T8iJcSN3_o.png"
            },
            "reddit": {
              "campaign": "http",
            },
            "flickr": {
              "original": [
                "https://farm8.staticflickr.com/7615/16670240949_8d43db0e36_o.jpg",
                "https://farm9.staticflickr.com/8597/16856369125_e97cd30ef7_o.jpg",
                "https://farm8.staticflickr.com/7586/16166732954_9338dc859c_o.jpg",
                "https://farm8.staticflickr.com/7603/16855223522_462da54e84_o.jpg",
                "https://farm8.staticflickr.com/7618/16234010894_e1210ec300_o.jpg",
                "https://farm8.staticflickr.com/7617/16855338881_69542a2fa9_o.jpg"
              ]
            },
            "presskit": "http",
            "webcast": "https://www.youtube.com/watch?v=0a_00nJ_Y88"
          },
          "static_fire_date_utc": "2006-03-17T00:00:00.000Z",
          "tbd": false,
          "net": false,
          "window": 0,
          "rocket": {
            "name": "Falcon 1",
            "id": "5e9d0d95eda69955f709d1eb",
          },
          "success": false,
          "failures": [
            {
              "time": 139,
              "altitude": 40,
              "reason":
                  "helium tank overpressure lead to the second stage LOX tank explosion"
            }
          ],
          "details": "Engine failure at 33 seconds and loss of vehicle",
          "payloads": [
            {
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
            }
          ],
          "launchpad": {
            'images': {
              'large': ['image.com']
            },
            "name": "Kwajalein Atoll",
            "full_name": "Kwajalein Atoll Omelek Island",
            "locality": "Omelek Island",
            "region": "Marshall Islands",
            "latitude": 9.0477206,
            "longitude": 167.7431292,
            "launch_attempts": 5,
            "launch_successes": 2,
            "details":
                "SpaceX's primary Falcon 9 pad, where all east coast Falcon 9s launched prior to the AMOS-6 anomaly. Previously used alongside SLC-41 to launch Titan rockets for the US Air Force, the pad was heavily damaged by the AMOS-6 anomaly in September 2016. It returned to flight with CRS-13 on December 15, 2017, boasting an upgraded throwback-style Transporter-Erector modeled after that at LC-39A.",
            "id": "5e9e4502f5090995de566f86"
          },
          "flight_number": 1,
          "name": "FalconSat",
          "date_utc": "2006-03-24T22:30:00.000Z",
          "date_precision": "hour",
          "upcoming": false,
          "cores": [
            {
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
                "landing_type": "ASDS",
                "wikipedia":
                    "https://en.wikipedia.org/wiki/Autonomous_spaceport_drone_ship",
                "details":
                    "The second ASDS barge, Of Course I Still Love You (OCISLY), had been under construction in a Louisiana shipyard since early 2015 using a different hull—Marmac 304—in order to service launches on the east coast. It was built as a replacement for the first Just Read the Instructions and entered operational service for Falcon 9 Flight 19 in late June 2015. As of June 2015, its home port was Jacksonville, Florida, but after December 2015, it was transferred 160 miles (260 km) further south, at Port Canaveral. While the dimensions of the ship are nearly identical to the first ASDS, several enhancements were made including a steel blast wall erected between the aft containers and the landing deck. The ship was in place for a first-stage landing test on the CRS-7 mission, which failed on launch on 28 June 2015. On 8 April 2016 the first stage, which launched the Dragon CRS-8 spacecraft, successfully landed for the first time ever on OCISLY, which is also the first ever drone ship landing. In February 2018, the Falcon Heavy Test Flight's central core exploded upon impact next to OCISLY that damaged two of the four thrusters on the drone ship. Two thrusters were removed from the Marmac 303 barge in order to repair OCISLY.",
                "status": "active",
                "id": "5e9e3032383ecb6bb234e7ca"
              }
            }
          ],
          "id": "5eb87cd9ffd86e000604b32a"
        }),
        Launch(
          patchUrl: 'https://images2.imgbox.com/3c/0e/T8iJcSN3_o.png',
          links: const [
            'https://www.youtube.com/watch?v=0a_00nJ_Y88',
            'http',
            'http',
          ],
          photos: const [
            "https://farm8.staticflickr.com/7615/16670240949_8d43db0e36_o.jpg",
            "https://farm9.staticflickr.com/8597/16856369125_e97cd30ef7_o.jpg",
            "https://farm8.staticflickr.com/7586/16166732954_9338dc859c_o.jpg",
            "https://farm8.staticflickr.com/7603/16855223522_462da54e84_o.jpg",
            "https://farm8.staticflickr.com/7618/16234010894_e1210ec300_o.jpg",
            "https://farm8.staticflickr.com/7617/16855338881_69542a2fa9_o.jpg"
          ],
          staticFireDate: DateTime.tryParse('2006-03-17T00:00:00.000Z'),
          launchWindow: 0,
          success: false,
          failure: FailureDetails(
            altitude: 40,
            time: 139,
            reason:
                'helium tank overpressure lead to the second stage LOX tank explosion',
          ),
          details: 'Engine failure at 33 seconds and loss of vehicle',
          rocket: RocketDetails(
            fairings: FairingsDetails(
              reused: true,
              recoveryAttempt: true,
              recovered: true,
            ),
            cores: [
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
            ],
            payloads: [
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
            ],
            name: 'Falcon 1',
            id: '5e9d0d95eda69955f709d1eb',
          ),
          launchpad: LaunchpadDetails(
            name: 'Kwajalein Atoll',
            fullName: 'Kwajalein Atoll Omelek Island',
            locality: 'Omelek Island',
            region: 'Marshall Islands',
            latitude: 9.0477206,
            longitude: 167.7431292,
            launchAttempts: 5,
            launchSuccesses: 2,
            details:
                "SpaceX's primary Falcon 9 pad, where all east coast Falcon 9s launched prior to the AMOS-6 anomaly. Previously used alongside SLC-41 to launch Titan rockets for the US Air Force, the pad was heavily damaged by the AMOS-6 anomaly in September 2016. It returned to flight with CRS-13 on December 15, 2017, boasting an upgraded throwback-style Transporter-Erector modeled after that at LC-39A.",
            id: '5e9e4502f5090995de566f86',
          ),
          flightNumber: 1,
          name: 'FalconSat',
          launchDate: DateTime.tryParse('2006-03-24T22:30:00.000Z'),
          datePrecision: 'hour',
          upcoming: false,
          id: '5eb87cd9ffd86e000604b32a',
        ),
      );
    });

    test('correctly returns launch window string', () {
      expect(
        Launch().getLaunchWindow(MockBuildContext()),
        'spacex.other.unknown',
      );

      expect(
        Launch(launchWindow: 0).getLaunchWindow(MockBuildContext()),
        'spacex.launch.page.rocket.instantaneous_window',
      );

      expect(
        Launch(launchWindow: 59).getLaunchWindow(MockBuildContext()),
        '59 s',
      );

      expect(
        Launch(launchWindow: 60).getLaunchWindow(MockBuildContext()),
        '1 min',
      );

      expect(
        Launch(launchWindow: 3599).getLaunchWindow(MockBuildContext()),
        '59 min',
      );

      expect(
        Launch(launchWindow: 3600).getLaunchWindow(MockBuildContext()),
        '1 h',
      );

      expect(
        Launch(launchWindow: 5000).getLaunchWindow(MockBuildContext()),
        '1h 23min',
      );
    });

    test('correctly returns launch details', () {
      expect(
        Launch().getDetails(MockBuildContext()),
        'spacex.launch.page.no_description',
      );

      expect(
        Launch(details: 'Lorem').getDetails(MockBuildContext()),
        'Lorem',
      );
    });

    test('correctly returns launch date info', () {
      expect(
        Launch(
          launchDate: DateTime(1970),
          datePrecision: 'hour',
        ).getLaunchDate(MockBuildContext()),
        'spacex.other.date.time',
      );

      expect(
        Launch(
          launchDate: DateTime(1970),
          datePrecision: 'day',
        ).getLaunchDate(MockBuildContext()),
        'spacex.other.date.upcoming',
      );
    });

    test('correctly returns static fire details', () {
      expect(
        Launch().getStaticFireDate(MockBuildContext()),
        'spacex.other.unknown',
      );

      expect(
        Launch(staticFireDate: DateTime.now())
            .getStaticFireDate(MockBuildContext()),
        DateFormat.yMMMMd().format(DateTime.now()),
      );
    });

    test('link menu works great', () {
      expect(
        Launch.getMenuIndex('spacex.launch.menu.reddit'),
        1,
      );

      expect(
        Launch.getMenuIndex('spacex.launch.menu.press_kit'),
        2,
      );

      expect(
        Launch(links: const ['google.com', 'google.es'])
            .isUrlEnabled('spacex.launch.menu.reddit'),
        true,
      );

      expect(
        Launch(links: const ['google.com', null])
            .isUrlEnabled('spacex.launch.menu.reddit'),
        false,
      );

      expect(
        Launch(links: const ['google.com', 'google.es'])
            .getUrl('spacex.launch.menu.reddit'),
        'google.es',
      );
    });

    test('correctly compares with other launch', () {
      expect(
        Launch(flightNumber: 1).compareTo(Launch(flightNumber: 2)),
        -1,
      );
      expect(
        Launch(flightNumber: 10).compareTo(Launch(flightNumber: 2)),
        1,
      );
      expect(
        Launch(flightNumber: 1).compareTo(Launch(flightNumber: 1)),
        0,
      );
    });

    test('correctly returns local launch date', () {
      final date = DateTime.now();
      expect(
        Launch(launchDate: date).localLaunchDate,
        date,
      );
    });

    test('correctly returns local static fire date', () {
      final date = DateTime.now();
      expect(
        Launch(staticFireDate: date).localStaticFireDate,
        date,
      );
    });

    test('correctly returns formatted flight number', () {
      expect(
        Launch(flightNumber: 1).getNumber,
        '#01',
      );
    });

    test('correctly checks for path image', () {
      expect(
        Launch(patchUrl: 'google.es').hasPatch,
        true,
      );
      expect(
        Launch().hasPatch,
        false,
      );
    });

    test('correctly checks for video', () {
      expect(
        Launch(links: const ['google.es']).hasVideo,
        true,
      );
      expect(
        Launch(links: const [null]).hasVideo,
        false,
      );
    });

    test('correctly returns video', () {
      expect(
        Launch(links: const ['google.es']).getVideo,
        'google.es',
      );
    });

    test('correctly checks for tentative hour', () {
      expect(
        Launch(datePrecision: 'hour').tentativeTime,
        false,
      );
      expect(
        Launch(datePrecision: '').tentativeTime,
        true,
      );
    });

    test('correctly returns tentative date', () {
      final date = DateTime(1970);
      expect(
        Launch(datePrecision: 'hour', launchDate: date).getTentativeDate,
        'January 1, 1970',
      );
      expect(
        Launch(datePrecision: 'day', launchDate: date).getTentativeDate,
        'January 1, 1970',
      );
      expect(
        Launch(datePrecision: 'month', launchDate: date).getTentativeDate,
        'January 1970',
      );
      expect(
        Launch(datePrecision: 'quarter', launchDate: date).getTentativeDate,
        'Q1 1970',
      );
      expect(
        Launch(datePrecision: 'half', launchDate: date).getTentativeDate,
        'H1 1970',
      );
      expect(
        Launch(datePrecision: 'year', launchDate: date).getTentativeDate,
        '1970',
      );
      expect(
        Launch(datePrecision: '', launchDate: date).getTentativeDate,
        'date error',
      );
    });

    test('correctly returns short tentative time', () {
      expect(
        Launch(launchDate: DateTime(1970)).getShortTentativeTime,
        '00:00',
      );
    });

    test('correctly returns short tentative time with time zone', () {
      final date = DateTime(1970);
      expect(
        Launch(launchDate: date).getTentativeTime,
        '00:00 ${date.timeZoneName}',
      );
    });

    test('correctly checks for too tentative launch date', () {
      expect(
        Launch(datePrecision: 'hour').isDateTooTentative,
        false,
      );
      expect(
        Launch(datePrecision: 'day').isDateTooTentative,
        false,
      );
      expect(
        Launch(datePrecision: '').isDateTooTentative,
        true,
      );
    });

    test('correctly returns launch year', () {
      expect(
        Launch(launchDate: DateTime(1970)).year,
        '1970',
      );
    });

    test('correctly checks for photos', () {
      expect(
        Launch(photos: const []).hasPhotos,
        false,
      );
      expect(
        Launch(photos: const ['']).hasPhotos,
        true,
      );
    });

    test('correctly checks for static fire occurrence', () {
      expect(
        Launch(
          staticFireDate: DateTime(1970),
          upcoming: false,
        ).avoidedStaticFire,
        false,
      );
      expect(
        Launch(
          staticFireDate: DateTime(1970),
          upcoming: true,
        ).avoidedStaticFire,
        false,
      );
      expect(
        Launch(
          upcoming: false,
        ).avoidedStaticFire,
        true,
      );
      expect(
        Launch(
          upcoming: true,
        ).avoidedStaticFire,
        false,
      );
    });
  });

  group('RocketDetails', () {
    test('is correctly generated from a JSON', () {
      expect(
        RocketDetails.fromJson(const {
          "fairings": {
            "reused": true,
            "recovery_attempt": true,
            "recovered": true,
            "ships": [
              {"name": "GO Ms Tree", "id": "5ea6ed2e080df4000697c908"}
            ]
          },
          "links": {
            "patch": {
              "small": "https://images2.imgbox.com/3c/0e/T8iJcSN3_o.png"
            },
            "reddit": {
              "campaign": "http",
            },
            "flickr": {
              "original": [
                "https://farm8.staticflickr.com/7615/16670240949_8d43db0e36_o.jpg",
                "https://farm9.staticflickr.com/8597/16856369125_e97cd30ef7_o.jpg",
                "https://farm8.staticflickr.com/7586/16166732954_9338dc859c_o.jpg",
                "https://farm8.staticflickr.com/7603/16855223522_462da54e84_o.jpg",
                "https://farm8.staticflickr.com/7618/16234010894_e1210ec300_o.jpg",
                "https://farm8.staticflickr.com/7617/16855338881_69542a2fa9_o.jpg"
              ]
            },
            "presskit": "http",
            "webcast": "https://www.youtube.com/watch?v=0a_00nJ_Y88"
          },
          "static_fire_date_utc": "2006-03-17T00:00:00.000Z",
          "tbd": false,
          "net": false,
          "window": 0,
          "rocket": {
            "name": "Falcon 1",
            "id": "5e9d0d95eda69955f709d1eb",
          },
          "success": false,
          "failures": {
            "time": 139,
            "altitude": 40,
            "reason":
                "helium tank overpressure lead to the second stage LOX tank explosion"
          },
          "details": "Engine failure at 33 seconds and loss of vehicle",
          "payloads": [
            {
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
            }
          ],
          "launchpad": {
            'images': {
              'large': ['image.com']
            },
            "name": "Kwajalein Atoll",
            "full_name": "Kwajalein Atoll Omelek Island",
            "locality": "Omelek Island",
            "region": "Marshall Islands",
            "latitude": 9.0477206,
            "longitude": 167.7431292,
            "launch_attempts": 5,
            "launch_successes": 2,
            "details":
                "SpaceX's primary Falcon 9 pad, where all east coast Falcon 9s launched prior to the AMOS-6 anomaly. Previously used alongside SLC-41 to launch Titan rockets for the US Air Force, the pad was heavily damaged by the AMOS-6 anomaly in September 2016. It returned to flight with CRS-13 on December 15, 2017, boasting an upgraded throwback-style Transporter-Erector modeled after that at LC-39A.",
            "id": "5e9e4502f5090995de566f86"
          },
          "flight_number": 1,
          "name": "FalconSat",
          "date_utc": "2006-03-24T22:30:00.000Z",
          "date_precision": "hour",
          "upcoming": false,
          "cores": [
            {
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
                "landing_type": "ASDS",
                "wikipedia":
                    "https://en.wikipedia.org/wiki/Autonomous_spaceport_drone_ship",
                "details":
                    "The second ASDS barge, Of Course I Still Love You (OCISLY), had been under construction in a Louisiana shipyard since early 2015 using a different hull—Marmac 304—in order to service launches on the east coast. It was built as a replacement for the first Just Read the Instructions and entered operational service for Falcon 9 Flight 19 in late June 2015. As of June 2015, its home port was Jacksonville, Florida, but after December 2015, it was transferred 160 miles (260 km) further south, at Port Canaveral. While the dimensions of the ship are nearly identical to the first ASDS, several enhancements were made including a steel blast wall erected between the aft containers and the landing deck. The ship was in place for a first-stage landing test on the CRS-7 mission, which failed on launch on 28 June 2015. On 8 April 2016 the first stage, which launched the Dragon CRS-8 spacecraft, successfully landed for the first time ever on OCISLY, which is also the first ever drone ship landing. In February 2018, the Falcon Heavy Test Flight's central core exploded upon impact next to OCISLY that damaged two of the four thrusters on the drone ship. Two thrusters were removed from the Marmac 303 barge in order to repair OCISLY.",
                "status": "active",
                "id": "5e9e3032383ecb6bb234e7ca"
              }
            }
          ],
          "id": "5eb87cd9ffd86e000604b32a"
        }),
        RocketDetails(
          fairings: FairingsDetails(
            reused: true,
            recoveryAttempt: true,
            recovered: true,
          ),
          cores: [
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
          ],
          payloads: [
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
          ],
          name: 'Falcon 1',
          id: '5e9d0d95eda69955f709d1eb',
        ),
      );
    });

    test('correctly checks whether rocket is heavy', () {
      expect(
        RocketDetails(cores: const [Core()]).isHeavy,
        false,
      );

      expect(
        RocketDetails(cores: const [Core(), Core(), Core()]).isHeavy,
        true,
      );
    });

    test('correctly checks whether rocket has fairings', () {
      expect(
        RocketDetails(fairings: FairingsDetails()).hasFairings,
        true,
      );
      expect(
        RocketDetails().hasFairings,
        false,
      );
    });

    test('correctly returns single core', () {
      expect(
        RocketDetails(
                cores: const [Core(id: '1'), Core(id: '2'), Core(id: '3')])
            .getSingleCore,
        Core(id: '1'),
      );
    });

    test('correctly checks whether core is a side one', () {
      final cores = [Core(id: '1'), Core(id: '2'), Core(id: '3')];
      expect(
        RocketDetails(id: '', cores: cores).isSideCore(cores[0]),
        false,
      );
      expect(
        RocketDetails(id: '', cores: cores).isSideCore(cores[1]),
        true,
      );
      expect(
        RocketDetails(id: '', cores: cores).isSideCore(cores[2]),
        true,
      );
      expect(
        RocketDetails(id: '', cores: [cores[0]]).isSideCore(cores[0]),
        false,
      );
    });

    test('correctly checks for a null first stage', () {
      final cores = [Core(id: '1'), Core(id: '2'), Core(id: '3')];
      expect(
        RocketDetails(cores: cores).isFirstStageNull,
        false,
      );
      expect(
        RocketDetails(cores: const [Core()]).isFirstStageNull,
        true,
      );
    });

    test('correctly checks for multiple payload', () {
      expect(
        RocketDetails(payloads: const [Payload()]).hasMultiplePayload,
        false,
      );
      expect(
        RocketDetails(payloads: const [Payload(), Payload()])
            .hasMultiplePayload,
        true,
      );
    });

    test('correctly returns single payload', () {
      expect(
        RocketDetails(payloads: const [Payload(id: '1')]).getSinglePayload,
        Payload(id: '1'),
      );
    });

    test('correctly checks for dragon capsule', () {
      expect(
        RocketDetails(
                payloads: const [Payload(id: '1', capsule: CapsuleDetails())])
            .hasCapsule,
        true,
      );
      expect(
        RocketDetails(payloads: const [Payload(id: '1')]).hasCapsule,
        false,
      );
    });

    test('correctly returns short tentative time', () {
      expect(
        RocketDetails(
                cores: const [Core(id: '1'), Core(id: '2'), Core(id: '3')])
            .getCore('1'),
        Core(id: '1'),
      );
    });
  });

  group('FairingsDetails', () {
    test('is correctly generated from a JSON', () {
      expect(
        FairingsDetails.fromJson(const {
          "reused": true,
          "recovery_attempt": true,
          "recovered": true,
          "ships": [
            {
              "name": "GO Ms Tree",
              "id": "5ea6ed2e080df4000697c908",
            }
          ]
        }),
        FairingsDetails(
          reused: true,
          recoveryAttempt: true,
          recovered: true,
        ),
      );
    });
  });

  group('FailureDetails', () {
    test('is correctly generated from a JSON', () {
      expect(
        FailureDetails.fromJson(const {
          "time": 139,
          "altitude": 40,
          "reason":
              "helium tank overpressure lead to the second stage LOX tank explosion"
        }),
        FailureDetails(
          time: 139,
          altitude: 40,
          reason:
              "helium tank overpressure lead to the second stage LOX tank explosion",
        ),
      );
    });

    test('correctly returns time', () {
      expect(
        FailureDetails(time: 59).getTime,
        'T+59 s',
      );
      expect(
        FailureDetails(time: 3599).getTime,
        'T+59min 59s',
      );
      expect(
        FailureDetails(time: 3600).getTime,
        'T+1h 0min',
      );
    });

    test('correctly returns reason', () {
      expect(
        FailureDetails(reason: 'test').getReason,
        'Test',
      );
    });

    test('correctly returns altitude', () {
      expect(
        FailureDetails().getAltitude(MockBuildContext()),
        'spacex.other.unknown',
      );

      expect(
        FailureDetails(altitude: 100).getAltitude(MockBuildContext()),
        '100 km',
      );
    });
  });
}
