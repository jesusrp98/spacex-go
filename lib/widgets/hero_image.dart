import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// HERO IMAGE
/// Class used into building hero images & their specific hero pages.
class HeroImage {
  static const double _maxSize = 150.0;
  static const Interval _opacityCurve =
      const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  static const num smallSize = 72.0, bigSize = 112.0;

  /// Method used to build the hero animation
  static RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

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
                    width: _maxSize * 2.0,
                    height: _maxSize * 2.0,
                    child: Hero(
                      createRectTween: _createRectTween,
                      tag: tag,
                      child: _Image(url: url, maxRadius: _maxSize),
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
        createRectTween: _createRectTween,
        tag: tag,
        child: _Image(url: url, maxRadius: _maxSize),
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
        createRectTween: _createRectTween,
        tag: tag,
        child: _Image(
          url: url,
          maxRadius: _maxSize,
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
  final double maxRadius, _size;
  final VoidCallback onTap;

  _Image({
    this.url,
    this.maxRadius,
    this.onTap,
  }) : _size = 2.0 * (maxRadius / math.sqrt2);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _size,
      height: _size,
      child: ClipRect(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: CachedNetworkImage(
              imageUrl: url,
              errorWidget: const Icon(Icons.error),
              fadeInDuration: Duration(milliseconds: 100),
            ),
          ),
        ),
      ),
    );
  }
}
