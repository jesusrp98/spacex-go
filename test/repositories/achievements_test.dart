import 'package:cherry/models/index.dart';
import 'package:cherry/repositories-cubit/index.dart';
import 'package:cherry/util/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock.dart';

void main() {
  group('AchievementsRepository', () {
    MockClient client;
    AchievementsRepository repository;

    setUp(() {
      client = MockClient();
      repository = AchievementsRepository(client);
    });

    test('throws AssertionError when client is null', () {
      expect(() => AchievementsRepository(null), throwsAssertionError);
    });

    test('returns request when client returns 200', () async {
      final response = MockResponse();
      const json = [
        {
          "links": {
            "article":
                "http://www.spacex.com/news/2013/02/11/flight-4-launch-update-0"
          },
          "title": "Falcon reaches Earth orbit",
          "event_date_utc": "2008-09-28T23:15:00Z",
          "event_date_unix": 1222643700,
          "details":
              "Falcon 1 becomes the first privately developed liquid-fuel rocket to reach Earth orbit.",
          "id": "5f6fb2cfdcfdf403df37971e"
        }
      ];

      when(
        client.get(Url.companyAchievements),
      ).thenAnswer((_) => Future.value(response));
      when(response.data).thenReturn(json);

      final output = await repository.fetchData();
      expect(output, [Achievement.fromJson(json.first)]);
    });
  });
}
