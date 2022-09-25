import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

extension Translate on BuildContext {
  String translate(String key, {Map<String, String>? parameters}) {
    try {
      return FlutterI18n.translate(
        this,
        key,
        translationParams: parameters,
      );
    } catch (_) {
      return key;
    }
  }
}
