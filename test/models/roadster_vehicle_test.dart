import 'package:cherry/models/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import 'mock_context.dart';

void main() {
  group('RoadsterVehicle', () {
    test('is correctly generated from a JSON', () {
      expect(
        RoadsterVehicle.fromJson(const {
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
        }),
        RoadsterVehicle(
          id: '5eb75f0842fea42237d7f3f4',
          description:
              "Elon Musk's Tesla Roadster is an electric sports car that served as the dummy payload for the February 2018 Falcon Heavy test flight and is now an artificial satellite of the Sun. Starman, a mannequin dressed in a spacesuit, occupies the driver's seat. The car and rocket are products of Tesla and SpaceX. This 2008-model Roadster was previously used by Musk for commuting, and is the only consumer car sent into space.",
          url: 'https://en.wikipedia.org/wiki/Elon_Musk%27s_Tesla_Roadster',
          mass: 1350,
          firstFlight: DateTime.parse('2018-02-06T20:45:00.000Z'),
          photos: const [
            "https://farm5.staticflickr.com/4615/40143096241_11128929df_b.jpg",
            "https://farm5.staticflickr.com/4702/40110298232_91b32d0cc0_b.jpg",
            "https://farm5.staticflickr.com/4676/40110297852_5e794b3258_b.jpg",
            "https://farm5.staticflickr.com/4745/40110304192_6e3e9a7a1b_b.jpg"
          ],
          orbit: 'heliocentric',
          video: 'https://youtu.be/wbSwFU6tY1c',
          apoapsis: 1.663953958687046,
          periapsis: 0.9858147198091061,
          inclination: 1.077447168391629,
          longitude: 317.0814558060362,
          period: 557.0130583804103,
          speed: 81565.80012,
          earthDistance: 91218798.05943623,
          marsDistance: 22540919.9995336,
        ),
      );
    });

    test('correctly retuns Mars distance', () {
      expect(
        RoadsterVehicle(marsDistance: 100).getMarsDistance,
        '100 km',
      );
    });

    test('correctly retuns Earth distance', () {
      expect(
        RoadsterVehicle(earthDistance: 100).getEarthDistance,
        '100 km',
      );
    });

    test('correctly retuns speed', () {
      expect(
        RoadsterVehicle(speed: 100).getSpeed,
        '100 km/h',
      );
    });

    test('correctly retuns longitude', () {
      expect(
        RoadsterVehicle(longitude: 100).getLongitude,
        '100°',
      );
    });

    test('correctly retuns inclination', () {
      expect(
        RoadsterVehicle(inclination: 100).getInclination,
        '100°',
      );
    });

    test('correctly retuns periapsis', () {
      expect(
        RoadsterVehicle(periapsis: 100).getPeriapsis,
        '100 ua',
      );
    });

    test('correctly retuns apoapsis', () {
      expect(
        RoadsterVehicle(apoapsis: 100).getApoapsis,
        '100 ua',
      );
    });

    test('correctly retuns orbit', () {
      expect(
        RoadsterVehicle(orbit: 'test').getOrbit,
        'Test',
      );
    });

    test('correctly retuns period', () {
      expect(
        RoadsterVehicle(period: 100).getPeriod(MockBuildContext()),
        'spacex.vehicle.roadster.orbit.days',
      );
    });

    test('correctly retuns subtitle text', () {
      expect(
        RoadsterVehicle(firstFlight: DateTime.now())
            .subtitle(MockBuildContext()),
        'spacex.vehicle.subtitle.launched',
      );
    });

    test('correctly retuns full launch date', () {
      expect(
        RoadsterVehicle(firstFlight: DateTime.now())
            .getFullLaunchDate(MockBuildContext()),
        'spacex.vehicle.subtitle.launched',
      );
    });

    test('correctly retuns full launch date', () {
      expect(
        RoadsterVehicle(firstFlight: DateTime.now())
            .getLaunchDate(MockBuildContext()),
        DateFormat.yMMMMd().format(DateTime.now()),
      );
    });
  });
}
