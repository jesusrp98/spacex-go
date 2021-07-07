import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// This widget helps by forcing a size to a cached image,
/// or anykind of widget, all around the app.
class ProfileImage extends StatelessWidget {
  static const smallSize = 40.0, bigSize = 69.0;

  final String url;
  final num size;
  final VoidCallback onTap;

  const ProfileImage({
    @required this.url,
    @required this.size,
    this.onTap,
  });

  /// Leading parameter of a [ListCell] widget.
  factory ProfileImage.small(String url) {
    return ProfileImage(url: url, size: smallSize);
  }

  /// Header of a [CardCell] widget.
  factory ProfileImage.big(String url, {VoidCallback onTap}) {
    return ProfileImage(url: url, size: bigSize, onTap: onTap);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: InkWell(
        onTap: onTap,
        child: url != null
            ? CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.fitHeight,
              )
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
