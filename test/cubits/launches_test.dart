import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';
import 'package:cherry/cubits/index.dart';
import 'package:cherry/models/index.dart';
import 'package:cherry/repositories/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLaunchesRepository extends Mock implements LaunchesRepository {}

void main() {
  group('LaunchesCubit', () {
    LaunchesCubit cubit;
    MockLaunchesRepository repository;

    setUp(() {
      repository = MockLaunchesRepository();
      cubit = LaunchesCubit(repository);
    });

    tearDown(() {
      cubit.close();
    });

    group('fetchData', () {
      blocTest<LaunchesCubit, RequestState>(
        'fetches data correctly',
        build: () {
          when(repository.fetchData()).thenAnswer(
            (_) => Future.value(const [
              [Launch(id: '1')]
            ]),
          );
          return cubit;
        },
        act: (cubit) async => cubit.loadData(),
        verify: (_) => verify(repository.fetchData()).called(2),
        expect: () => [
          RequestState<List<List<Launch>>>.loading(),
          RequestState<List<List<Launch>>>.loaded(const [
            [Launch(id: '1')]
          ]),
        ],
      );

      blocTest<LaunchesCubit, RequestState>(
        'can throw an exception',
        build: () {
          when(repository.fetchData()).thenThrow(Exception('wtf'));
          return cubit;
        },
        act: (cubit) async => cubit.loadData(),
        verify: (_) => verify(repository.fetchData()).called(2),
        expect: () => [
          RequestState<List<List<Launch>>>.loading(),
          RequestState<List<List<Launch>>>.error(Exception('wtf').toString()),
        ],
      );
    });

    group('getter', () {
      test('getLaunch works correctly', () async {
        when(repository.fetchData()).thenAnswer(
          (_) => Future.value([
            [Launch(id: '1')],
            [Launch(id: '2')]
          ]),
        );
        await cubit.loadData();
        expect(cubit.getLaunch('1'), Launch(id: '1'));
      });
    });
  });
}
