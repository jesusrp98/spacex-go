import 'package:cherry/models/index.dart';
import 'package:cherry/repositories/index.dart';
import 'package:cherry/services/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock.dart';

class MockVehiclesService extends Mock implements VehiclesService {}

void main() {
  group('VehiclesRepository', () {
    MockVehiclesService service;
    VehiclesRepository repository;

    setUp(() {
      service = MockVehiclesService();
      repository = VehiclesRepository(service);
    });

    test('returns request when service returns 200', () async {
      final roadsterResponse = MockResponse();
      const roadsterJson = {
        "flickr_images": [
          "https://farm5.staticflickr.com/4615/40143096241_11128929df_b.jpg",
          "https://farm5.staticflickr.com/4702/40110298232_91b32d0cc0_b.jpg",
          "https://farm5.staticflickr.com/4676/40110297852_5e794b3258_b.jpg",
          "https://farm5.staticflickr.com/4745/40110304192_6e3e9a7a1b_b.jpg"
        ],
        "name": "Elon Musk's Tesla Roadster",
        "launch_date_utc": "2018-02-06T20:45:00.000Z",
        "launch_date_unix": 1517949900,
        "launch_mass_kg": 1350,
        "launch_mass_lbs": 2976,
        "norad_id": 43205,
        "epoch_jd": 2459099.747048611,
        "orbit_type": "heliocentric",
        "apoapsis_au": 1.663953958687046,
        "periapsis_au": 0.9858147198091061,
        "semi_major_axis_au": 251.4894388260824,
        "eccentricity": 0.2559239394673542,
        "inclination": 1.077447168391629,
        "longitude": 317.0814558060362,
        "periapsis_arg": 177.5319554749398,
        "period_days": 557.0130583804103,
        "speed_kph": 81565.80012,
        "speed_mph": 50682.62278636452,
        "earth_distance_km": 91218798.05943623,
        "earth_distance_mi": 56680715.76898995,
        "mars_distance_km": 22540919.9995336,
        "mars_distance_mi": 14006274.001030194,
        "wikipedia":
            "https://en.wikipedia.org/wiki/Elon_Musk%27s_Tesla_Roadster",
        "video": "https://youtu.be/wbSwFU6tY1c",
        "details":
            "Elon Musk's Tesla Roadster is an electric sports car that served as the dummy payload for the February 2018 Falcon Heavy test flight and is now an artificial satellite of the Sun. Starman, a mannequin dressed in a spacesuit, occupies the driver's seat. The car and rocket are products of Tesla and SpaceX. This 2008-model Roadster was previously used by Musk for commuting, and is the only consumer car sent into space.",
        "id": "5eb75f0842fea42237d7f3f4"
      };

      final dragonResponse = MockResponse();
      const dragonJson = {
        'docs': [
          {
            'launch_payload_mass': {'kg': 6000},
            'return_payload_mass': {'kg': 3000},
            'height_w_trunk': {'meters': 7.2},
            'diameter': {'meters': 3.7},
            'first_flight': '2010-12-08',
            'flickr_images': [
              'https://i.imgur.com/9fWdwNv.jpg',
              'https://live.staticflickr.com/8578/16655995541_7817565ea9_k.jpg',
              'https://farm3.staticflickr.com/2815/32761844973_4b55b27d3c_b.jpg',
              'https://farm9.staticflickr.com/8618/16649075267_d18cbb4342_b.jpg'
            ],
            'name': 'Dragon 1',
            'type': 'capsule',
            'active': true,
            'crew_capacity': 0,
            'dry_mass_kg': 4200,
            'thrusters': [
              {
                'type': 'Draco',
                'amount': 18,
                'fuel_1': 'nitrogen tetroxide',
                'fuel_2': 'monomethylhydrazine',
                'isp': 300,
                'thrust': {'kN': 0.4}
              }
            ],
            'wikipedia': 'https://en.wikipedia.org/wiki/SpaceX_Dragon',
            'description':
                'Dragon is a reusable spacecraft developed by SpaceX, an American private space transportation company based in Hawthorne, California. Dragon is launched into space by the SpaceX Falcon 9 two-stage-to-orbit launch vehicle. The Dragon spacecraft was originally designed for human travel, but so far has only been used to deliver cargo to the International Space Station (ISS).',
            'id': '5e9d058759b1ff74a7ad5f8f'
          }
        ]
      };

      final rocketResponse = MockResponse();
      const rocketJson = {
        'docs': [
          {
            'height': {'meters': 22.25},
            'diameter': {'meters': 1.68},
            'mass': {'kg': 30146},
            'first_stage': {
              'thrust_sea_level': {'kN': 420},
              'thrust_vacuum': {'kN': 480},
              'reusable': false,
              'engines': 1,
              'fuel_amount_tons': 44.3
            },
            'second_stage': {
              'thrust': {'kN': 31},
              'payloads': {
                'composite_fairing': {
                  'height': {'meters': 3.5},
                  'diameter': {'meters': 1.5}
                }
              },
              'reusable': false,
              'engines': 1,
              'fuel_amount_tons': 3.38
            },
            'engines': {
              'isp': {'sea_level': 267, 'vacuum': 304},
              'thrust_sea_level': {'kN': 420},
              'thrust_vacuum': {'kN': 480},
              'type': 'merlin',
              'version': '1C',
              'propellant_1': 'liquid oxygen',
              'propellant_2': 'RP-1 kerosene',
              'thrust_to_weight': 96
            },
            'payload_weights': [
              {'id': 'leo', 'name': 'Low Earth Orbit', 'kg': 450}
            ],
            'flickr_images': [
              'https://imgur.com/DaCfMsj.jpg',
              'https://imgur.com/azYafd8.jpg'
            ],
            'name': 'Falcon 1',
            'type': 'rocket',
            'active': false,
            'stages': 2,
            'boosters': 0,
            'cost_per_launch': 6700000,
            'success_rate_pct': 40,
            'first_flight': '2006-03-24',
            'wikipedia': 'https://en.wikipedia.org/wiki/Falcon_1',
            'description':
                'The Falcon 1 was an expendable launch system privately developed and manufactured by SpaceX during 2006-2009. On 28 September 2008, Falcon 1 became the first privately-developed liquid-fuel launch vehicle to go into orbit around the Earth.',
            'id': '5e9d0d95eda69955f709d1eb'
          }
        ]
      };

      final shipResponse = MockResponse();
      const shipJson = {
        'docs': [
          {
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
          }
        ]
      };

      when(
        service.getRoadster(),
      ).thenAnswer((_) => Future.value(roadsterResponse));
      when(roadsterResponse.data).thenReturn(roadsterJson);

      when(
        service.getDragons(),
      ).thenAnswer((_) => Future.value(dragonResponse));
      when(dragonResponse.data).thenReturn(dragonJson);

      when(
        service.getRockets(),
      ).thenAnswer((_) => Future.value(rocketResponse));
      when(rocketResponse.data).thenReturn(rocketJson);

      when(
        service.getShips(),
      ).thenAnswer((_) => Future.value(shipResponse));
      when(shipResponse.data).thenReturn(shipJson);

      final output = await repository.fetchData();
      expect(output, [
        RoadsterVehicle.fromJson(roadsterJson),
        DragonVehicle.fromJson(dragonJson['docs'].single),
        RocketVehicle.fromJson(rocketJson['docs'].single),
        ShipVehicle.fromJson(shipJson['docs'].single),
      ]);
    });
  });
}
