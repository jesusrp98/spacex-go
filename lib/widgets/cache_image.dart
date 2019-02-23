import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// CACHE IMAGE WIDGET
/// Auxiliary widget to display a cached image.
/// It has its own 'error' widget.
class CacheImage extends StatelessWidget {
  final String url;

  CacheImage(this.url);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      errorWidget: (context, url, error) => Icon(
            Icons.cancel,
            size: 32,
            color: Theme.of(context).textTheme.caption.color,
          ),
      fadeInDuration: Duration(milliseconds: 100),
      fit: BoxFit.cover,
    );
  }
}
