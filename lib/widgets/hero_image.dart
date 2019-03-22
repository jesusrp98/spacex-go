import 'package:flutter/material.dart';

import 'cache_image.dart';

/// HERO IMAGE WIDGET
/// Auxiliary widget with builds a cached hero image.
class HeroImage extends StatelessWidget {
  static const num _smallSize = 56.0, _bigSize = 80.0;

  final String url, tag;
  final num size;
  final VoidCallback onTap;

  HeroImage({
    @required this.url,
    @required this.tag,
    @required this.size,
    this.onTap,
  });

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

  /// Buils a HeroImage sized to fit in a [leading] parameter of a [ListTile] widget
  factory HeroImage.list({String url, String tag}) {
    return HeroImage(url: url, tag: tag, size: _smallSize);
  }

  /// Buils a HeroImage sized to fit in a [leading] parameter of a [HeadCardPage] widget
  factory HeroImage.card({String url, String tag, VoidCallback onTap}) {
    return HeroImage(url: url, tag: tag, size: _bigSize, onTap: onTap);
  }
}
