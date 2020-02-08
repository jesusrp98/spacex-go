import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ImageQuality { low, medium, high }

const ImageQuality _defaultQuality = ImageQuality.medium;

/// Saves and loads information regarding the image quality setting.
class ImageQualityProvider with ChangeNotifier {
  ImageQuality _imageQuality = ImageQuality.medium;

  ImageQualityProvider() {
    init();
  }

  ImageQuality get imageQuality => _imageQuality;

  set imageQuality(ImageQuality imageQuality) {
    _imageQuality = imageQuality;
    notifyListeners();
  }

  /// Load image quality information from local storage
  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      imageQuality = ImageQuality.values[prefs.getInt('quality')];
    } catch (e) {
      prefs.setInt('quality', ImageQuality.values.indexOf(_defaultQuality));
    }

    notifyListeners();
  }
}
