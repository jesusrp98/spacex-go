import 'package:bloc_test/bloc_test.dart';
import 'package:cherry/cubits/index.dart';
import 'package:cherry/models/index.dart';
import 'package:cherry/repositories/index.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAchievementsRepository extends Mock
    implements AchievementsRepository {}

void main() {
  group('AchievementsCubit', () {
    AchievementsCubit cubit;
    MockAchievementsRepository repository;

    setUp(() {
      repository = MockAchievementsRepository();
      cubit = AchievementsCubit(repository);
    });

    tearDown(() {
      cubit.close();
    });

    group('fetchData', () {
      blocTest<AchievementsCubit, RequestState>(
        'fetches data correctly',
        build: () {
          when(repository.fetchData()).thenAnswer(
            (_) => Future.value(const [Achievement(id: '1')]),
          );
          return cubit;
        },
        act: (cubit) async => cubit.loadData(),
        verify: (_) => verify(repository.fetchData()).called(2),
        expect: () => [
          RequestState<List<Achievement>>.loading(),
          RequestState<List<Achievement>>.loaded(const [Achievement(id: '1')]),
        ],
      );

      blocTest<AchievementsCubit, RequestState>(
        'can throw an exception',
        build: () {
          when(repository.fetchData()).thenThrow(Exception('wtf'));
          return cubit;
        },
        act: (cubit) async => cubit.loadData(),
        verify: (_) => verify(repository.fetchData()).called(2),
        expect: () => [
          RequestState<List<Achievement>>.loading(),
          RequestState<List<Achievement>>.error(Exception('wtf').toString()),
        ],
      );
    });
  });
}
