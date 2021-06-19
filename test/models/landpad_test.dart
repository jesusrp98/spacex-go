import 'package:cherry/models/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';

void main() {
  group('LandpadDetails', () {
    test('is correctly generated from a JSON', () {
      expect(
        LandpadDetails.fromJson(const {
          'images': {
            'large': ['image.com']
          },
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

    test('correctly returns coordenates', () {
      expect(
        LandpadDetails(latitude: 28, longitude: -80).coordinates,
        LatLng(28, -80),
      );
    });

    test('correctly returns status', () {
      expect(
        LandpadDetails(status: 'test').getStatus,
        'Test',
      );
    });

    test('correctly returns string coordenates', () {
      expect(
        LandpadDetails(latitude: 28, longitude: -80).getCoordinates,
        '28.000,  -80.000',
      );
    });

    test('correctly returns successful landings', () {
      expect(
        LandpadDetails(landingAttempts: 10, landingSuccesses: 5)
            .getSuccessfulLandings,
        '5/10',
      );
    });
  });
}
