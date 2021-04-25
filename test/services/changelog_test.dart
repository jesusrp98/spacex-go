import 'package:cherry/services/index.dart';
import 'package:cherry/utils/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import './mock.dart';

void main() {
  group('ChangelogService', () {
    MockClient client;
    ChangelogService service;

    setUp(() {
      client = MockClient();
      service = ChangelogService(client);
    });

    test('returns changelog when client returns 200', () async {
      const json = 'Just a normal JSON here';
      final response = MockResponse();

      when(response.statusCode).thenReturn(200);
      when(response.data).thenReturn(json);
      when(
        client.get(Url.changelog),
      ).thenAnswer((_) => Future.value(response));

      final output = await service.getChangelog();
      expect(output.data, json);
    });
  });
}
