import 'package:cherry/models/index.dart';
import 'package:cherry/repositories/index.dart';
import 'package:cherry/services/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock.dart';

class MockLaunchesService extends Mock implements LaunchesService {}

void main() {
  group('LaunchesRepository', () {
    MockLaunchesService service;
    LaunchesRepository repository;

    setUp(() {
      service = MockLaunchesService();
      repository = LaunchesRepository(service);
    });

    test('returns request when service returns 200', () async {
      final response = MockResponse();
      const json = {
        'docs': [
          {
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
          }
        ]
      };

      when(response.data).thenReturn(json);
      when(service.getLaunches()).thenAnswer((_) => Future.value(response));

      final output = await repository.fetchData();
      expect(output, [
        [],
        [Launch.fromJson(json['docs'].single)]
      ]);
    });
  });
}
