import 'package:cherry/models/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';

void main() {
  group('LaunchpadDetails', () {
    test('is correctly generated from a JSON', () {
      expect(
        LaunchpadDetails.fromJson(const {
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
          details:
              "SpaceX's primary Falcon 9 pad, where all east coast Falcon 9s launched prior to the AMOS-6 anomaly. Previously used alongside SLC-41 to launch Titan rockets for the US Air Force, the pad was heavily damaged by the AMOS-6 anomaly in September 2016. It returned to flight with CRS-13 on December 15, 2017, boasting an upgraded throwback-style Transporter-Erector modeled after that at LC-39A.",
          id: '5e9e4502f5090995de566f86',
        ),
      );
    });

    test('correctly returns coordenates', () {
      expect(
        LaunchpadDetails(latitude: 28, longitude: -80).coordinates,
        LatLng(28, -80),
      );
    });

    test('correctly returns status', () {
      expect(
        LaunchpadDetails(status: 'test').getStatus,
        'Test',
      );
    });

    test('correctly returns string coordenates', () {
      expect(
        LaunchpadDetails(latitude: 28, longitude: -80).getCoordinates,
        '28.000,  -80.000',
      );
    });

    test('correctly returns successful landings', () {
      expect(
        LaunchpadDetails(launchAttempts: 10, launchSuccesses: 5)
            .getSuccessfulLaunches,
        '5/10',
      );
    });
  });
}
