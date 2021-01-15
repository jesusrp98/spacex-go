import 'dart:math';

import 'package:cherry/models/index.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock_context.dart';

void main() {
  group('DragonVehicle', () {
    test('is correctly generated from a JSON', () {
      expect(
        DragonVehicle.fromJson(const {
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
        }),
        DragonVehicle(
          id: '5e9d058759b1ff74a7ad5f8f',
          name: 'Dragon 1',
          type: 'capsule',
          description:
              'Dragon is a reusable spacecraft developed by SpaceX, an American private space transportation company based in Hawthorne, California. Dragon is launched into space by the SpaceX Falcon 9 two-stage-to-orbit launch vehicle. The Dragon spacecraft was originally designed for human travel, but so far has only been used to deliver cargo to the International Space Station (ISS).',
          url: 'https://en.wikipedia.org/wiki/SpaceX_Dragon',
          height: 7.2,
          diameter: 3.7,
          mass: 4200,
          active: true,
          firstFlight: DateTime.parse('2010-12-08'),
          photos: const [
            'https://i.imgur.com/9fWdwNv.jpg',
            'https://live.staticflickr.com/8578/16655995541_7817565ea9_k.jpg',
            'https://farm3.staticflickr.com/2815/32761844973_4b55b27d3c_b.jpg',
            'https://farm9.staticflickr.com/8618/16649075267_d18cbb4342_b.jpg'
          ],
          crew: 0,
          launchMass: 6000,
          returnMass: 3000,
          thrusters: const [
            Thruster(
              model: 'Draco',
              oxidizer: 'nitrogen tetroxide',
              fuel: 'monomethylhydrazine',
              isp: 300,
              amount: 18,
              thrust: 0.4,
            ),
          ],
          reusable: true,
        ),
      );
    });

    test('correctly returns subtitle', () {
      expect(
        DragonVehicle(firstFlight: DateTime(1970)).subtitle(MockBuildContext()),
        'spacex.vehicle.subtitle.first_launched',
      );

      expect(
        DragonVehicle(firstFlight: DateTime.now().add(Duration(days: 1)))
            .subtitle(MockBuildContext()),
        'spacex.vehicle.subtitle.scheduled_launch',
      );
    });

    test('correctly returns crew info', () {
      expect(
        DragonVehicle(crew: 0).getCrew(MockBuildContext()),
        'spacex.vehicle.capsule.description.no_people',
      );

      expect(
        DragonVehicle(crew: 1).getCrew(MockBuildContext()),
        'spacex.vehicle.capsule.description.people',
      );
    });

    test('correctly returns crew enabled', () {
      expect(
        DragonVehicle(crew: 1).isCrewEnabled,
        true,
      );
    });

    test('correctly returns launch mass', () {
      expect(
        DragonVehicle(launchMass: 100).getLaunchMass,
        '100 kg',
      );
    });

    test('correctly returns return mass', () {
      expect(
        DragonVehicle(returnMass: 100).getReturnMass,
        '100 kg',
      );
    });

    test('correctly returns height', () {
      expect(
        DragonVehicle(height: 10).getHeight,
        '10 m',
      );
    });

    test('correctly returns diameter', () {
      expect(
        DragonVehicle(diameter: 10).getDiameter,
        '10 m',
      );
    });

    test('correctly returns full first flight', () {
      expect(
        DragonVehicle(firstFlight: DateTime(1970)).getFullFirstFlight,
        'January 1, 1970',
      );
      expect(
        DragonVehicle(firstFlight: DateTime(3000)).getFullFirstFlight,
        'January 3000',
      );
    });

    test('correctly returns photos', () {
      final photos = ['one', 'two', 'three'];

      expect(
        DragonVehicle(photos: photos).getProfilePhoto,
        photos[0],
      );
      expect(
        DragonVehicle(photos: photos).getRandomPhoto(Random(0)),
        photos[0],
      );
      expect(
        DragonVehicle(photos: [photos[0]]).getRandomPhoto(),
        photos[0],
      );
    });
  });

  group('Thruster', () {
    test('is correctly generated from a JSON', () {
      expect(
        Thruster.fromJson(const {
          'type': 'Draco',
          'amount': 18,
          'fuel_1': 'nitrogen tetroxide',
          'fuel_2': 'monomethylhydrazine',
          'isp': 300,
          'thrust': {'kN': 0.4}
        }),
        Thruster(
          model: 'Draco',
          amount: 18,
          oxidizer: 'nitrogen tetroxide',
          fuel: 'monomethylhydrazine',
          isp: 300,
          thrust: 0.4,
        ),
      );
    });

    test('correctly returns fuel string', () {
      expect(
        Thruster(fuel: 'test').getFuel,
        'Test',
      );
    });

    test('correctly returns oxidizer string', () {
      expect(
        Thruster(oxidizer: 'test').getOxidizer,
        'Test',
      );
    });

    test('correctly returns thruster amount', () {
      expect(
        Thruster(amount: 2).getAmount,
        '2',
      );
    });

    test('correctly returns thrust', () {
      expect(
        Thruster(thrust: 2).getThrust,
        '2 kN',
      );
    });

    test('correctly returns isp', () {
      expect(
        Thruster(isp: 2).getIsp,
        '2 s',
      );
    });
  });
}
