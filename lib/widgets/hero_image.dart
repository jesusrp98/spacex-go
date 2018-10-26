import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// HERO IMAGE
/// Class used into building hero images & their specific hero pages.
class HeroImage {
  static const num smallSize = 64.0, bigSize = 112.0, pageSize = 248.0;

  /// Builds the hero image page
  static Widget _buildPage({
    BuildContext context,
    String url,
    String tag,
    String title,
  }) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: FlatButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Center(
          child: Card(
            color: Theme.of(context).cardColor,
            elevation: 6.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: pageSize,
                    height: pageSize,
                    child: Hero(
                      tag: tag,
                      child: _Image(url: url, size: pageSize),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a hero image
  Widget buildHero({
    BuildContext context,
    double size,
    String url,
    String tag,
    String title,
  }) {
    return Container(
      width: size,
      height: size,
      child: Hero(
        tag: tag,
        child: _Image(url: url, size: smallSize),
      ),
    );
  }

  /// Builds a expanded hero image
  Widget buildExpandedHero({
    BuildContext context,
    double size,
    String url,
    String tag,
    String title,
  }) {
    return Container(
      width: size,
      height: size,
      child: Hero(
        tag: tag,
        child: _Image(
          url: url,
          size: bigSize,
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => _buildPage(
                        context: context,
                        url: url,
                        tag: tag,
                        title: title,
                      ),
                ),
              ),
        ),
      ),
    );
  }
}

/// IMAGE CLASS
/// Private class which receives an image url & more to display a image network.
class _Image extends StatelessWidget {
  final String url;
  final double size;
  final VoidCallback onTap;

  _Image({
    this.url,
    this.size,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipRect(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              errorWidget: const Icon(Icons.error),
              fadeInDuration: Duration(milliseconds: 100),
            ),
          ),
        ),
      ),
    );
  }
}
