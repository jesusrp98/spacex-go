import 'package:bloc_test/bloc_test.dart';
import 'package:cherry/cubits/index.dart';
import 'package:cherry/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/hydrated.dart';

void main() {
  initHydratedBloc();
  group('ThemeCubit', () {
    ThemeCubit cubit;

    setUp(() {
      cubit = ThemeCubit();
    });

    test('has initial value', () async {
      expect(cubit.state, ThemeState.system);
      expect(cubit.theme, ThemeState.system);
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        expect(
          cubit.fromJson(cubit.toJson(cubit.state)),
          cubit.state,
        );
      });
    });

    blocTest<ThemeCubit, ThemeState>(
      'can change its state',
      build: () => cubit,
      act: (cubit) => cubit.theme = ThemeState.black,
      expect: () => [
        ThemeState.black,
      ],
    );

    test('has default light theme', () async {
      expect(cubit.lightTheme, Style.light);
    });

    test('has default dark theme', () async {
      expect(cubit.darkTheme, Style.dark);
      cubit.theme = ThemeState.black;
      expect(cubit.darkTheme, Style.black);
    });

    test('returns ThemeMode correctly', () async {
      cubit.theme = ThemeState.system;
      expect(cubit.themeMode, ThemeMode.system);
      cubit.theme = ThemeState.light;
      expect(cubit.themeMode, ThemeMode.light);
      cubit.theme = ThemeState.dark;
      expect(cubit.themeMode, ThemeMode.dark);
      cubit.theme = ThemeState.black;
      expect(cubit.themeMode, ThemeMode.dark);
    });
  });
}
