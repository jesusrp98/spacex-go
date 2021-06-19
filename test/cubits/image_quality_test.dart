import 'package:bloc_test/bloc_test.dart';
import 'package:cherry/cubits/index.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/hydrated.dart';

void main() {
  initHydratedBloc();
  group('ImageQualityCubit', () {
    ImageQualityCubit cubit;

    setUp(() {
      cubit = ImageQualityCubit();
    });

    test('has initial value', () async {
      expect(cubit.state, ImageQuality.medium);
      expect(cubit.imageQuality, ImageQuality.medium);
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        expect(
          cubit.fromJson(cubit.toJson(cubit.state)),
          cubit.state,
        );
      });
    });

    blocTest<ImageQualityCubit, ImageQuality>(
      'can change its state',
      build: () => cubit,
      act: (cubit) {
        cubit.imageQuality = ImageQuality.high;
        cubit.imageQuality = ImageQuality.low;
      },
      expect: () => [
        ImageQuality.high,
        ImageQuality.low,
      ],
    );
  });
}
