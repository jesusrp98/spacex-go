import 'package:bloc_test/bloc_test.dart';
import 'package:cherry/cubits/index.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/hydrated.dart';

void main() {
  initHydratedBloc();
  group('BrowserCubit', () {
    BrowserCubit cubit;

    setUp(() {
      cubit = BrowserCubit();
    });

    test('has initial value', () async {
      expect(cubit.state, BrowserType.inApp);
      expect(cubit.browserType, BrowserType.inApp);
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        expect(
          cubit.fromJson(cubit.toJson(cubit.state)),
          cubit.state,
        );
      });
    });

    blocTest<BrowserCubit, BrowserType>(
      'can change its state',
      build: () => cubit,
      act: (cubit) {
        cubit.browserType = BrowserType.system;
      },
      expect: () => [
        BrowserType.system,
      ],
    );
  });
}
