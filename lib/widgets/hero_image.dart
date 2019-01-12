import 'package:flutter/material.dart';

import 'cache_image.dart';

/// HERO IMAGE WIDGET
/// Auxiliary widget with builds a cached hero image.
class HeroImage extends StatelessWidget {
  static const num _smallSize = 64.0, _bigSize = 100.0;

  final String url, tag;
  final num size;
  final VoidCallback onTap;

  HeroImage({this.url, this.tag, this.size, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: InkWell(
        onTap: onTap,
        child: Hero(tag: tag, child: CacheImage(url)),
      ),
    );
  }

  factory HeroImage.list({String url, String tag}) {
    return HeroImage(url: url, tag: tag, size: _smallSize, onTap: null);
  }

  factory HeroImage.card({String url, String tag, VoidCallback onTap}) {
    return HeroImage(url: url, tag: tag, size: _bigSize, onTap: onTap);
  }
}
