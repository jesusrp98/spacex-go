import 'package:cherry/models/index.dart';
import 'package:flutter_test/flutter_test.dart';

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
  });
}
