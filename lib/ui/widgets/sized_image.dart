import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'index.dart';

///
class SizedImage extends StatelessWidget {
  static const num _smallSize = 40.0, _bigSize = 69.0;

  final String url;
  final num size;
  final VoidCallback onTap;

  const SizedImage({
    @required this.url,
    @required this.size,
    this.onTap,
  });

  ///
  factory SizedImage.list(String url) {
    return SizedImage(url: url, size: _smallSize);
  }

  ///
  factory SizedImage.card(String url, {VoidCallback onTap}) {
    return SizedImage(url: url, size: _bigSize, onTap: onTap);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: InkWell(
        onTap: onTap,
        child: url != null
            ? CacheImage(url)
            : SvgPicture.asset(
                'assets/icons/patch.svg',
                colorBlendMode: BlendMode.srcATop,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black45
                    : Colors.black26,
              ),
      ),
    );
  }
}
