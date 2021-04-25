import 'package:cherry/services/index.dart';
import 'package:cherry/utils/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import './mock.dart';

void main() {
  group('VehiclesService', () {
    MockClient client;
    VehiclesService service;

    setUp(() {
      client = MockClient();
      service = VehiclesService(client);
    });

    test('returns dragon request when client returns 200', () async {
      const json = 'Just a normal JSON here';
      final response = MockResponse();

      when(response.statusCode).thenReturn(200);
      when(response.data).thenReturn(json);
      when(
        client.post(
          Url.dragons,
          data: ApiQuery.dragonVehicle,
        ),
      ).thenAnswer((_) => Future.value(response));

      final output = await service.getDragons();
      expect(output.data, json);
    });

    test('returns roadster request when client returns 200', () async {
      const json = 'Just a normal JSON here';
      final response = MockResponse();

      when(response.statusCode).thenReturn(200);
      when(response.data).thenReturn(json);
      when(
        client.post(
          Url.roadster,
          data: ApiQuery.roadsterVehicle,
        ),
      ).thenAnswer((_) => Future.value(response));

      final output = await service.getRoadster();
      expect(output.data, json);
    });

    test('returns rockets request when client returns 200', () async {
      const json = 'Just a normal JSON here';
      final response = MockResponse();

      when(response.statusCode).thenReturn(200);
      when(response.data).thenReturn(json);
      when(
        client.post(
          Url.rockets,
          data: ApiQuery.rocketVehicle,
        ),
      ).thenAnswer((_) => Future.value(response));

      final output = await service.getRockets();
      expect(output.data, json);
    });

    test('returns ships request when client returns 200', () async {
      const json = 'Just a normal JSON here';
      final response = MockResponse();

      when(response.statusCode).thenReturn(200);
      when(response.data).thenReturn(json);
      when(
        client.post(
          Url.ships,
          data: ApiQuery.shipVehicle,
        ),
      ).thenAnswer((_) => Future.value(response));

      final output = await service.getShips();
      expect(output.data, json);
    });
  });
}
