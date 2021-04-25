import 'package:cherry/services/index.dart';
import 'package:cherry/utils/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import './mock.dart';

void main() {
  group('AchievementsService', () {
    MockClient client;
    AchievementsService service;

    setUp(() {
      client = MockClient();
      service = AchievementsService(client);
    });

    test('returns Achievements when client returns 200', () async {
      const json = ['Just a normal JSON here'];
      final response = MockResponse();

      when(response.statusCode).thenReturn(200);
      when(response.data).thenReturn(json);
      when(
        client.get(Url.companyAchievements),
      ).thenAnswer((_) => Future.value(response));

      final output = await service.getAchievements();
      expect(output.data.cast<String>(), json);
    });
  });
}
