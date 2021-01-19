import 'package:bloc_test/bloc_test.dart';
import 'package:cherry/cubits/base/index.dart';
import 'package:cherry/cubits/index.dart';
import 'package:cherry/repositories-cubit/changelog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'helpers/hydrated.dart';

class MockRepository extends Mock implements ChangelogRepository {}

void main() {
  initHydratedBloc();
  group('ChangelogCubit', () {
    ChangelogCubit cubit;
    MockRepository repository;

    setUp(() {
      repository = MockRepository();
      cubit = ChangelogCubit(repository);
    });

    test('fails when null service is provided', () {
      expect(() => ChangelogCubit(null), throwsAssertionError);
    });

    test('initial state is RequestState.init()', () {
      expect(ChangelogCubit(repository).state, RequestState<String>.init());
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        expect(
          cubit.fromJson(cubit.toJson(cubit.state)),
          cubit.state,
        );
      });
    });

    blocTest<ChangelogCubit, RequestState>(
      'fetches data correctly',
      build: () {
        when(repository.fetchData()).thenAnswer(
          (_) => Future.value('Lorem'),
        );
        return cubit;
      },
      act: (cubit) => cubit.loadData(),
      expect: [RequestState.loading(), RequestState.loaded('Lorem')],
    );
  });
}
