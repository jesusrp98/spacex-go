import 'package:cherry/providers/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('ImageQualityProvider', () {
    ImageQualityProvider provider;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      provider = ImageQualityProvider();
    });

    test('has initial value', () async {
      expect(provider.imageQuality, ImageQuality.medium);
    });

    test('can change its value', () async {
      provider.imageQuality = ImageQuality.high;
      expect(provider.imageQuality, ImageQuality.high);
    });
  });
}
