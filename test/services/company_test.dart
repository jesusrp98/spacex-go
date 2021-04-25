import 'package:cherry/services/index.dart';
import 'package:cherry/utils/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import './mock.dart';

void main() {
  group('CompanyService', () {
    MockClient client;
    CompanyService service;

    setUp(() {
      client = MockClient();
      service = CompanyService(client);
    });

    test('returns Achievements when client returns 200', () async {
      const json = ['Just a normal JSON here'];
      final response = MockResponse();

      when(response.statusCode).thenReturn(200);
      when(response.data).thenReturn(json);
      when(
        client.get(Url.companyAchievements),
      ).thenAnswer((_) => Future.value(response));
    });

    test('returns CompanyInfo when client returns 200', () async {
      const json = 'Just a normal JSON here';
      final response = MockResponse();

      when(response.statusCode).thenReturn(200);
      when(response.data).thenReturn(json);
      when(
        client.get(Url.companyInformation),
      ).thenAnswer((_) => Future.value(response));

      final output = await service.getCompanyInformation();
      expect(output.data, json);
    });
  });
}
