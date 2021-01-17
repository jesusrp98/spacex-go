import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

String translate(
  final BuildContext context,
  final String key, {
  final Map<String, String> translationParams,
}) {
  try {
    return FlutterI18n.translate(
      context,
      key,
      translationParams: translationParams,
    );
  } catch (_) {
    return key;
  }
}
