import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ImageQuality { low, medium, high }

/// TODO
class ImageModel with ChangeNotifier {
  ImageQuality _imageQuality = ImageQuality.medium;

  ImageModel() {
    init();
  }

  ImageQuality get imageQuality => _imageQuality;

  set imageQuality(ImageQuality imageQuality) {
    _imageQuality = imageQuality;
    notifyListeners();
  }

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      imageQuality = ImageQuality.values[prefs.getInt('quality')];
    } catch (e) {
      prefs.setInt('quality', 1);
    }

    notifyListeners();
  }
}
