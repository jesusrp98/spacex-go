import 'package:hydrated_bloc/hydrated_bloc.dart';

enum BrowserType { inApp, system }

/// Supports browser type selection on the user side.
/// - The [BrowserType.inApp] will display the URL inside an 'in-app' browser tab,
/// using the system default web browser.
/// - The [BrowserType.system] will open the web page inside the system default
/// web browser.
class BrowserCubit extends HydratedCubit<BrowserType> {
  static const defaultBrowser = BrowserType.inApp;

  BrowserCubit() : super(defaultBrowser);

  @override
  BrowserType fromJson(Map<String, dynamic> json) {
    return BrowserType.values[json['value']];
  }

  @override
  Map<String, int> toJson(BrowserType state) {
    return {
      'value': state.index,
    };
  }

  BrowserType get browserType => state;

  set browserType(BrowserType browserType) => emit(browserType);
}
