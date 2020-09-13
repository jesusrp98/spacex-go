import 'package:cherry/models/index.dart';
import 'package:flutter_test/flutter_test.dart';

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
          "failures": ["merlin engine failure"],
          "details": "Engine failure at 33 seconds and loss of vehicle",
          "crew": [
            {
              "name": "Douglas Hurley",
              "agency": "NASA",
              "image": "https://i.imgur.com/ooaayWf.png",
              "wikipedia": "https://en.wikipedia.org/wiki/Douglas_G._Hurley",
              "launches": [
                {
                  "flight_number": 94,
                  "name": "CCtCap Demo Mission 2",
                  "id": "5eb87d46ffd86e000604b388"
                }
              ],
              "status": "active",
              "id": "5ebf1b7323a9a60006e03a7b"
            }
          ],
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
                      "id": "5eb87ce1ffd86e000604b333"
                    }
                  ],
                  "serial": "C104",
                  "status": "unknown",
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
            "name": "Kwajalein Atoll",
            "full_name": "Kwajalein Atoll Omelek Island",
            "locality": "Omelek Island",
            "region": "Marshall Islands",
            "latitude": 9.0477206,
            "longitude": 167.7431292,
            "launch_attempts": 5,
            "launch_successes": 2,
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
          tbd: false,
          net: false,
          launchWindow: 0,
          success: false,
          failure: 'merlin engine failure',
          details: 'Engine failure at 33 seconds and loss of vehicle',
          rocket: RocketDetails(
            fairings: FairingsDetails(
              reused: true,
              recoveryAttempt: true,
              recovered: true,
              ships: const [
                ShipDetails(
                  name: 'GO Ms Tree',
                  id: '5ea6ed2e080df4000697c908',
                )
              ],
            ),
            cores: const [
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
            crew: const [
              Crew(
                name: 'Douglas Hurley',
                agency: 'NASA',
                imageUrl: 'https://i.imgur.com/ooaayWf.png',
                wikipediaUrl: 'https://en.wikipedia.org/wiki/Douglas_G._Hurley',
                launches: [
                  LaunchDetails(
                    flightNumber: 94,
                    name: 'CCtCap Demo Mission 2',
                    id: '5eb87d46ffd86e000604b388',
                  ),
                ],
                status: 'active',
                id: '5ebf1b7323a9a60006e03a7b',
              )
            ],
            payloads: const [
              Payload(
                capsule: CapsuleDetails(
                  reuseCount: 1,
                  splashings: 1,
                  lastUpdate: 'descripction',
                  launches: [
                    LaunchDetails(
                      flightNumber: 10,
                      name: 'CRS-2',
                      id: '5eb87ce1ffd86e000604b333',
                    )
                  ],
                  serial: 'C104',
                  status: 'unknown',
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
            "reddit": {"campaign": "http"},
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
          "failures": ["merlin engine failure"],
          "details": "Engine failure at 33 seconds and loss of vehicle",
          "crew": [
            {
              "name": "Douglas Hurley",
              "agency": "NASA",
              "image": "https://i.imgur.com/ooaayWf.png",
              "wikipedia": "https://en.wikipedia.org/wiki/Douglas_G._Hurley",
              "launches": [
                {
                  "flight_number": 94,
                  "name": "CCtCap Demo Mission 2",
                  "id": "5eb87d46ffd86e000604b388"
                }
              ],
              "status": "active",
              "id": "5ebf1b7323a9a60006e03a7b"
            }
          ],
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
                      "id": "5eb87ce1ffd86e000604b333"
                    }
                  ],
                  "serial": "C104",
                  "status": "unknown",
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
            "name": "Kwajalein Atoll",
            "full_name": "Kwajalein Atoll Omelek Island",
            "locality": "Omelek Island",
            "region": "Marshall Islands",
            "latitude": 9.0477206,
            "longitude": 167.7431292,
            "launch_attempts": 5,
            "launch_successes": 2,
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
            }
          ],
          "id": "5eb87cd9ffd86e000604b32a"
        }),
        RocketDetails(
          fairings: FairingsDetails(
            reused: true,
            recoveryAttempt: true,
            recovered: true,
            ships: const [
              ShipDetails(
                name: 'GO Ms Tree',
                id: '5ea6ed2e080df4000697c908',
              )
            ],
          ),
          cores: const [
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
          crew: const [
            Crew(
              name: 'Douglas Hurley',
              agency: 'NASA',
              imageUrl: 'https://i.imgur.com/ooaayWf.png',
              wikipediaUrl: 'https://en.wikipedia.org/wiki/Douglas_G._Hurley',
              launches: [
                LaunchDetails(
                  flightNumber: 94,
                  name: 'CCtCap Demo Mission 2',
                  id: '5eb87d46ffd86e000604b388',
                ),
              ],
              status: 'active',
              id: '5ebf1b7323a9a60006e03a7b',
            )
          ],
          payloads: const [
            Payload(
              capsule: CapsuleDetails(
                reuseCount: 1,
                splashings: 1,
                lastUpdate: 'descripction',
                launches: [
                  LaunchDetails(
                    flightNumber: 10,
                    name: 'CRS-2',
                    id: '5eb87ce1ffd86e000604b333',
                  )
                ],
                serial: 'C104',
                status: 'unknown',
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
          ships: const [
            ShipDetails(
              name: 'GO Ms Tree',
              id: '5ea6ed2e080df4000697c908',
            )
          ],
        ),
      );
    });
  });

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
          launches: const [
            LaunchDetails(
              flightNumber: 1,
              name: 'FalconSat',
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
  });

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
          launches: const [
            LaunchDetails(
              flightNumber: 94,
              name: 'CCtCap Demo Mission 2',
              id: '5eb87d46ffd86e000604b388',
            ),
          ],
          status: 'active',
          id: '5ebf1b7323a9a60006e03a7b',
        ),
      );
    });
  });

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
                  "id": "5eb87ce1ffd86e000604b333"
                }
              ],
              "serial": "C104",
              "status": "unknown",
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
            launches: const [
              LaunchDetails(
                flightNumber: 10,
                name: 'CRS-2',
                id: '5eb87ce1ffd86e000604b333',
              )
            ],
            serial: 'C104',
            status: 'unknown',
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
  });

  group('LaunchpadDetails', () {
    test('is correctly generated from a JSON', () {
      expect(
        LaunchpadDetails.fromJson(const {
          "name": "Kwajalein Atoll",
          "full_name": "Kwajalein Atoll Omelek Island",
          "locality": "Omelek Island",
          "region": "Marshall Islands",
          "latitude": 9.0477206,
          "longitude": 167.7431292,
          "launch_attempts": 5,
          "launch_successes": 2,
          "id": "5e9e4502f5090995de566f86"
        }),
        LaunchpadDetails(
          name: 'Kwajalein Atoll',
          fullName: 'Kwajalein Atoll Omelek Island',
          locality: 'Omelek Island',
          region: 'Marshall Islands',
          latitude: 9.0477206,
          longitude: 167.7431292,
          launchAttempts: 5,
          launchSuccesses: 2,
          id: '5e9e4502f5090995de566f86',
        ),
      );
    });
  });

  group('CapsuelDetails', () {
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
          launches: const [
            LaunchDetails(
              flightNumber: 10,
              name: 'CRS-2',
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

  group('ShipDetails', () {
    test('is correctly generated from a JSON', () {
      expect(
        ShipDetails.fromJson(const {
          'name': 'OCISLY',
          'id': '5e9e3032383ecb6bb234e7ca',
        }),
        ShipDetails(
          name: 'OCISLY',
          id: '5e9e3032383ecb6bb234e7ca',
        ),
      );
    });
  });

  group('LandpadDetails', () {
    test('is correctly generated from a JSON', () {
      expect(
        LandpadDetails.fromJson(const {
          'name': 'OCISLY',
          'full_name': 'Of Course I Still Love You',
          'type': 'ASDS',
          'locality': 'Port Canaveral',
          'region': 'Florida',
          'latitude': 28.4104,
          'longitude': -80.6188,
          'landing_attempts': 36,
          'landing_successes': 30,
          'wikipedia':
              'https://en.wikipedia.org/wiki/Autonomous_spaceport_drone_ship',
          'details':
              "The second ASDS barge, Of Course I Still Love You (OCISLY), had been under construction in a Louisiana shipyard since early 2015 using a different hull—Marmac 304—in order to service launches on the east coast. It was built as a replacement for the first Just Read the Instructions and entered operational service for Falcon 9 Flight 19 in late June 2015. As of June 2015, its home port was Jacksonville, Florida, but after December 2015, it was transferred 160 miles (260 km) further south, at Port Canaveral. While the dimensions of the ship are nearly identical to the first ASDS, several enhancements were made including a steel blast wall erected between the aft containers and the landing deck. The ship was in place for a first-stage landing test on the CRS-7 mission, which failed on launch on 28 June 2015. On 8 April 2016 the first stage, which launched the Dragon CRS-8 spacecraft, successfully landed for the first time ever on OCISLY, which is also the first ever drone ship landing. In February 2018, the Falcon Heavy Test Flight's central core exploded upon impact next to OCISLY that damaged two of the four thrusters on the drone ship. Two thrusters were removed from the Marmac 303 barge in order to repair OCISLY.",
          'status': 'active',
          'id': '5e9e3032383ecb6bb234e7ca'
        }),
        LandpadDetails(
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
      );
    });
  });
}
