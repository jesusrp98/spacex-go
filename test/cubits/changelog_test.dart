import 'package:bloc_test/bloc_test.dart';
import 'package:cherry/cubits/base/index.dart';
import 'package:cherry/cubits/index.dart';
import 'package:cherry/repositories/changelog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/mockito.dart';

class MockRepository extends Mock implements ChangelogRepository {}

class MockStorage extends Mock implements Storage {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ChangelogCubit', () {
    MockRepository repository;
    Storage storage;

    setUp(() {
      storage = MockStorage();
      repository = MockRepository();

      // final response = MockResponse();

      // when(response.statusCode).thenReturn(200);
      // when(response.data).thenReturn(json);

      HydratedCubit.storage = storage;

      // when(storage.write(any, any)).thenAnswer((_) => Future.value(response));
      // when(repository.loadData()).thenAnswer((realInvocation) => null);
    });

    test('fails when null service is provided', () {
      expect(() => ChangelogCubit(null), throwsAssertionError);
    });

    test('initial state is RequestState.init()', () {
      expect(ChangelogCubit(repository).state, RequestState<String>.init());
    });

    // blocTest(
    //   'fetches data correctly',
    //   build: () {
    //     when(service.getChangelog()).thenAnswer(
    //       (_) => Future.value(
    //         ModelReleaseRequest(
    //           items: [
    //             ModelRelease(
    //               release: Release(
    //                 models: [
    //                   Model(id: '1'),
    //                   Model(id: '2'),
    //                 ],
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     );
    //     return ChangelogCubit(service);
    //   },
    //   act: (cubit) => cubit.fetchData(),
    //   expect: [RequestState.loading(), RequestState.loaded('Lorem')],
    // );
  });
}
