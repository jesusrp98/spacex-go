import 'package:cherry/providers/index.dart';
import 'package:cherry/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('ThemeProvider', () {
    ThemeProvider provider;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      provider = ThemeProvider();
    });

    test('has initial value', () async {
      expect(provider.theme, Themes.system);
    });

    test('can change its value', () async {
      provider.theme = Themes.light;
      expect(provider.theme, Themes.light);
    });

    test('has default light theme', () async {
      expect(provider.lightTheme, Style.light);
    });

    test('has default dark theme', () async {
      expect(provider.darkTheme, Style.dark);
      provider.theme = Themes.black;
      expect(provider.darkTheme, Style.black);
    });

    test('returns ThemeMode correctly', () async {
      provider.theme = Themes.system;
      expect(provider.themeMode, ThemeMode.system);
      provider.theme = Themes.light;
      expect(provider.themeMode, ThemeMode.light);
      provider.theme = Themes.dark;
      expect(provider.themeMode, ThemeMode.dark);
      provider.theme = Themes.black;
      expect(provider.themeMode, ThemeMode.dark);
    });
  });
}
