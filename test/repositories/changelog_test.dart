import 'package:cherry/repositories-cubit/index.dart';
import 'package:cherry/util/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock.dart';

void main() {
  group('ChangelogRepository', () {
    MockClient client;
    ChangelogRepository repository;

    setUp(() {
      client = MockClient();
      repository = ChangelogRepository(client);
    });

    test('throws AssertionError when client is null', () {
      expect(() => ChangelogRepository(null), throwsAssertionError);
    });

    test('returns request when client returns 200', () async {
      final response = MockResponse();
      const json = 'Just a normal JSON here';

      when(
        client.get(Url.changelog),
      ).thenAnswer((_) => Future.value(response));
      when(response.data).thenReturn(json);

      final output = await repository.fetchData();
      expect(output, json);
    });
  });
}
