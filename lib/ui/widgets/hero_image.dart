import 'package:flutter/material.dart';

import 'index.dart';

/// Auxiliary widget with builds a cached hero image.
class HeroImage extends StatelessWidget {
  static const num _smallSize = 49.0, _bigSize = 69.0;

  final String url, tag;
  final num size;
  final VoidCallback onTap;

  const HeroImage({
    @required this.url,
    @required this.tag,
    @required this.size,
    this.onTap,
  });

  /// Buils a HeroImage sized to fit in a [leading] parameter of a [ListTile] widget
  factory HeroImage.list({String url, String tag}) {
    return HeroImage(url: url, tag: tag, size: _smallSize);
  }

  /// Buils a HeroImage sized to fit in a [leading] parameter of a [HeadCardPage] widget
  factory HeroImage.card({String url, String tag, VoidCallback onTap}) {
    return HeroImage(url: url, tag: tag, size: _bigSize, onTap: onTap);
  }

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
}
