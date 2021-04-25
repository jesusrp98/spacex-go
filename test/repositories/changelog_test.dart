import 'package:cherry/repositories/index.dart';
import 'package:cherry/services/changelog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock.dart';

class MockChangelogService extends Mock implements ChangelogService {}

void main() {
  group('ChangelogRepository', () {
    ChangelogService service;
    ChangelogRepository repository;

    setUp(() {
      service = MockChangelogService();
      repository = ChangelogRepository(service);
    });

    test('returns request when client returns 200', () async {
      final response = MockResponse();
      const json = 'Just a normal JSON here';

      when(
        service.getChangelog(),
      ).thenAnswer((_) => Future.value(response));
      when(response.data).thenReturn(json);

      final output = await repository.fetchData();
      expect(output, json);
    });
  });
}
